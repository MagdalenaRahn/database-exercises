USE farmers_market;

-- Let's Review our Tables:
-- TABLE : booth
SELECT *
FROM booth;
-- Contains : booth_number, booth_price_level, booth_description, booth_type
-- How could we use it ? Lets us know the features of each of the 12 booths in the farmer's market

-- TABLE : customer
SELECT *
FROM customer;
-- Contains customer_id, customer_first_name, customer_last_name, customer_zip
-- How could we use it ? Lets us know the names and zip codes of each of the 26 customers in the farmer's market

-- TABLE : customer_purchases
SELECT *
FROM customer_purchases;
-- Contains product_id, vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty, transaction_time
-- How could we use it ? Lets us know details of each purchase made by a customer in the farmers' market

-- TABLE : product
SELECT *
FROM product; 
-- Contains product_id, product_name, product_size, product_category_id, product_qty_type
-- How to use it ? This describes what each product is.

-- TABLE : product_category
SELECT *
FROM product_category;
-- Contains product_category_id, product_category_name
-- How could we use it ? Lets us know the name and id number of 7 product categories in the farmers' market

-- TABLE : vendor
SELECT *
FROM vendor;
-- Contains vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name
-- How could we use it ? Lets us know the details of each of the 9 vendors in the farmers' market

-- TABLE : vendor_booth_assignments
SELECT *
FROM vendor_booth_assignments;
-- Contains vendor_id, booth_number, market_date
-- How could we use it ? Lets us know which booths were assigned to which vendor each day

-- TABLE : vendor_inventory
SELECT *
FROM vendor_inventory;
-- Contains market_date, quantity, vendor_id, product_id, original_price
-- How could we use it ? It's not 100% clear, but this may contain info on how much of each product each vendor had at the start or end of a given day

-- TABLE : zip_data
SELECT *
FROM zip_data;
-- Contains zip_code_5, median_household_income, percent_high_income, percent_under_18, percent_over_65
-- people_per_sq_mile, latitude, longitude
-- How could we use it ? This gives is socio-economic information about the zip codes related to customers


-- Q1: What is the average minimum temperature across all Saturdays?

SELECT * 
FROM market_date_info; 

SELECT AVG(market_min_temp)
FROM market_date_info
WHERE market_day = 'Saturday';

-- Q2: Generate a report that only returns market_date_info where the market_min_temp was lower than the average . THE FOLLOWING QUERY IS ERROR-ED
-- market_min_temp 
SELECT *
FROM market_date_info
WHERE market_min_temp < AVG(market_min_temp);

-- > USE A SUBQUERY (SCALAR) TO MAKE THIS WORK CORRECTLY. THIS QUERY ALLOWS FOR DATA TO CHANGE / BE UPDATED AND STILL GET ACCURATE RESULTS.
SELECT * FROM market_date_info
WHERE market_min_temp < (SELECT AVG(market_min_temp) FROM market_date_info);


-- Q3. WHICH VENDORS IN THE MARKET ON 2019-04-03 ?
SELECT * FROM vendor_booth_assignments
WHERE market_date = '2019-04-03';

-- Q4. Give all the historical data for the specific vendors who were in the market on 2019-04-03.
SELECT * FROM vendor
WHERE vendor_id IN (SELECT vendor_id
					FROM vendor_booth_assignments
					WHERE market_date = '2019-04-03'
					);
				/* this takes the query from Q3 and replaces the * with the 'select' in the 'IN' statement matching the 'where' outside of the parethetical query. */
				
				
-- Row Subquery Process : returns a single row.
-- Q5. What is the first and last name of the most recent customer ? cannot take max number, becuase that might take customer who made the latest-in-clock-time purchase ever
SELECT * FROM customer_purchases
ORDER BY market_date DESC, transaction_time DESC /* this first organises data by market date, then by transaction time within each market date */
LIMIT 1;

SELECT customer_first_name, customer_last_name FROM customer
WHERE customer_id = (SELECT customer_id
					FROM customer_purchases
					ORDER BY market_date DESC, transaction_time DESC
					LIMIT 1
						);

-- same as JOINING (both contain 'customer_id') :

SELECT *
FROM customer AS c
JOIN customer_purchases AS cp 
	ON c.customer_id = cp.customer_id;
	
SELECT customer_first_name, customer_last_name
FROM customer AS c
JOIN customer_purchases AS cp 
	ON c.customer_id = cp.customer_id
ORDER BY market_date DESC, transaction_time DESC
LIMIT 1;


-- Table Subquery.
-- 
SELECT customer_id, 
			CONCAT(customer_first_name, ' - ', customer_zip) AS cust_ZIP
FROM customer;


SELECT customer_id, 
			CONCAT(customer_first_name, ' - ', customer_zip) AS cust_ZIP
FROM customer
ORDER BY cust_ZIP ASC;


SELECT * FROM customer_purchases AS cp
JOIN (SELECT customer_id, 
			CONCAT(customer_first_name, ' - ', customer_zip) AS cust_ZIP
			FROM customer
			ORDER BY cust_ZIP ASC
			) AS cz ON cp.customer_id = cz.customer_id;
			/* cz.customer_id is derived from customer table, using output from query in parenthese as an hypothetical table */
			
-- CRAZY Q1a. What is the qverage quantity by customer_id ?
SELECT customer_id, AVG(quantity) AS 'average_quantity'
FROM customer_purchases
GROUP BY customer_id;

-- /* CRAZY Q1b. What is the average of the average ? --> Note the referencing of the 'average_quantity' from above alias right off the bat in the AVG function. */
SELECT AVG (average_quantity)
FROM (
		SELECT customer_id, AVG(quantity) AS 'average_quantity'
		FROM customer_purchases
		GROUP BY customer_id
		) AS aq;
		
-- /* What if I forgot to alias my column in my subquery ? **It gets stuck.** Use aliases for subqueries in order to make them referenceable. */
SELECT AVG(AVG(quantity))
FROM (
		SELECT customer_id, AVG(quantity)
		FROM customer_purchases
		GROUP BY customer_id
		) AS aq;