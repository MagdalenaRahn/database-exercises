USE albums_db;
SELECT *
FROM albums;

SHOW tables;
DESCRIBE albums;

SELECT DISTINCT artist
FROM albums;

SELECT name, release_date
FROM albums
ORDER BY release_date ASC;
/* 

3. Explore the structure of the albums table.

a. How many rows are in the albums table? 
31 rows (7 columns).

b. How many unique artist names are in the albums table?
23 unique artist names.

c. What is the primary key for the albums table?
id.

d. What is the oldest release date for any album in the albums table? What is the most recent release date?
1967.
*/

SELECT artist, name
FROM albums
WHERE artist = 'Pink Floyd';
/* This is Q4a on Exercises. */

SELECT artist, name, release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
/* This is Q4b on Exercises. */

SELECT genre FROM albums
WHERE name = 'Nevermind';
/* This is Q4c on Exercises. */

SELECT name, release_date FROM albums
WHERE release_date BETWEEN '1990' AND '1999';
/* This is Q4d on Exercises. */

SELECT name, sales FROM albums
WHERE sales < '20';
/* This is Q4e on Exercises. */

SELECT artist, name, genre FROM albums
WHERE genre = 'Rock';
/* This is Q4f on Exercises. These results do not includes 'hard rock' or 'progressive rock' because the query specified 'rock' as an entire / a whole search term, not as a subset of a search term. To get the term 'rock' as a term included in the results, the WHERE line would read : WHERE genre LIKE '%Rock%'; 
*/