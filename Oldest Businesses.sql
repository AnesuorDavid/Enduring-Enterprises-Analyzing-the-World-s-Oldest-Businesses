-- DATA IMPORT
SELECT * 
FROM businesses
LIMIT 5;
-- DATA CLEANING AND NORMALISATION
SELECT `ï»¿index`, business, year_founded, category_code, country_code -- CHECKING FOR BLANK SPACES AND NULL VALUES
FROM businesses
WHERE `ï»¿index` IS NULL OR `ï»¿index` = ''
AND business IS NULL OR business = ''
AND year_founded  IS NULL OR year_founded = ''
AND category_code IS NULL OR category_code = ''
AND country_code IS NULL OR country_code = ''
GROUP BY  `ï»¿index`, business, year_founded, category_code, country_code;
-- CHECKING FOR REPEATED VALUES
SELECT `ï»¿index`, business, year_founded, category_code, country_code, COUNT(*) AS occurences
FROM businesses
GROUP BY  `ï»¿index`, business, year_founded, category_code, country_code
HAVING   COUNT(*) > 1;
-- STAGING table
CREATE TABLE enduring_businesses 
LIKE businesses;
INSERT INTO enduring_businesses
SELECT *
FROM businesses;
SELECT *
FROM enduring_businesses
LIMIT 5;
-- DATA AGGREGATION
-- 1.	Which business categories are best suited to last over the course of centuries?
SELECT category_code, COUNT(*) AS freq
FROM enduring_businesses
GROUP BY category_code
ORDER BY freq DESC;
SELECT DISTINCT category_code
FROM enduring_businesses;
SELECT category_code, MIN(year_founded) AS earliest_year
FROM enduring_businesses
GROUP BY category_code
ORDER BY earliest_year ASC;
SELECT business, category_code, year_founded, country_code
FROM enduring_businesses
WHERE category_code = 'CAT6'
ORDER BY year_founded;
	-- 2.	What is the oldest business in the dataset overall?
	SELECT business, year_founded
	FROM enduring_businesses
	GROUP BY business, year_founded
	ORDER BY year_founded
	limit 1;
SELECT *
FROM businesses;
 -- 3.	How has the rate of new business founding changed over time?
 SELECT year_founded, COUNT(*) AS num_businesses_founded
FROM enduring_businesses
GROUP BY year_founded
ORDER BY year_founded ASC
limit 15;
SELECT *
FROM enduring_businesses
WHERE year_founded = 1878;
-- 5.	Which industries or sectors contain the highest number of century-old businesses?
SELECT category_code, COUNT(*) AS freq
FROM enduring_businesses
GROUP BY category_code
ORDER BY freq DESC
LIMIT 5;
SELECT * 
FROM enduring_businesses
WHERE category_code = 'CAT18'
LIMIT 5;
-- 6.	What is the average founding year per business category?
SELECT  category_code, ROUND(AVG(year_founded),0) AS Avg_founding_date 
FROM enduring_businesses
GROUP BY category_code
ORDER BY Avg_founding_date DESC ;

-- 8.	How many businesses still operating today were founded before 1800?
SELECT  COUNT(*)
FROM enduring_businesses
WHERE year_founded > 1800;
-- 9.	Are there any categories that show consistent business formation across multiple centuries?
SELECT 
  category_code,
  FLOOR(year_founded / 100) + 1 AS century,
  COUNT(*) AS businesses_founded
FROM enduring_businesses
GROUP BY category_code, century
HAVING category_code = 'CAT12'
ORDER BY category_code, century;

-- 10.	Which business category has the most businesses founded in the 20th century?
SELECT 
  category_code,
  COUNT(*) AS businesses_founded_20th
FROM enduring_businesses
WHERE year_founded BETWEEN 1901 AND 2000
GROUP BY category_code
ORDER BY businesses_founded_20th DESC;
