-- use the cities table : how many different countries represented ?
DESCRIBE city ; -- ID, Name, CountryCode, District, Population


SELECT COUNT(DISTINCT CountryCode)
FROM city;


-- which countries have the most entries ? (WHICH COUNTRIES APPEAR THE MOST ?)

SELECT DISTINCT CountryCode, COUNT(*) AS Number_Of
FROM city
GROUP BY CountryCode
ORDER BY Number_Of DESC;


-- what is the average city population in the dataset ?
SELECT AVG(Population) as Avg_Population
FROM city;


-- how many cities fall below the average population ?

SELECT Name, Population
FROM city
WHERE Population <= '350468.2236'
ORDER BY Population DESC;


SELECT COUNT(Name)
FROM city
WHERE Population < (SELECT AVG(Population) as Avg_Population
					FROM city);


-- which city has the highest population of all ?
Select Name, Population
FROM city
ORDER BY Population DESC
LIMIT 1;

SELECT Name, Population
fROM city
WHERE Population = (SELECT MAX(Population) as Max_Population
					FROM city);



