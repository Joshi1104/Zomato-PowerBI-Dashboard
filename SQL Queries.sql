-- ========================================================================================
-- Question 1:  What is the most popular/most visited restaurant based on total votes.
-- ========================================================================================
SELECT 
    name, votes, location
FROM
    customer_data
GROUP BY name , votes , location
ORDER BY votes DESC
LIMIT 5;

-- ========================================================================================
-- Question 2: What is the highest rated restaurant and in which locality/area.
-- ========================================================================================
SELECT 
    name, ratings, votes
FROM
    customer_data
ORDER BY ratings DESC
LIMIT 5;

-- ========================================================================================
-- Question 3:	What is the average rate of food.
-- ========================================================================================

SELECT 
    AVG(cost)
FROM
    customer_data;

-- ========================================================================================
-- Question 4:	What place has the highest number unique of restaurants
-- ========================================================================================

SELECT 
    COUNT(DISTINCT name) AS total_restaurant, location
FROM
    customer_data
GROUP BY location
ORDER BY total_restaurant DESC
LIMIT 5;

-- ========================================================================================
-- Question 5:-	What are the top liked dishes (top 5).
-- ========================================================================================

SELECT TRIM(dish) AS dish, COUNT(DISH) AS total_times_liked
FROM customer_data,
JSON_TABLE(
    CONCAT('["', REPLACE(dish_liked, ',', '","'), '"]'),
    '$[*]' COLUMNS(dish VARCHAR(100) PATH '$')
) AS extracted_dish GROUP BY TRIM(dish) ORDER BY total_times_liked DESC LIMIT 5;

-- ========================================================================================
-- Question 6:	What are the restaurants with high votes, but poor ratings.
-- ========================================================================================

SELECT 
    name,
    ROUND(AVG(votes), 1) AS avg_votes,
    ROUND(AVG(ratings), 1) AS avg_rating
FROM
    customer_data
GROUP BY name
ORDER BY avg_votes DESC , avg_rating
LIMIT 10;

-- ========================================================================================
-- Question 7:	What are the restaurants with low votes, but high ratings.
-- ========================================================================================

SELECT 
    name,
    ROUND(AVG(votes), 1) AS avg_votes,
    ROUND(AVG(ratings), 1) AS avg_rating
FROM
    customer_data
GROUP BY name
HAVING avg_rating >= 4
ORDER BY avg_rating DESC , avg_votes
LIMIT 10;

-- ========================================================================================
-- Question 8:	Which restaurant has the highest number of cuisines types to offer.
-- ========================================================================================

SELECT name, LENGTH(cuisines) - LENGTH(REPLACE(cuisines, ',', '')) + 1 
  as total_cuisines FROM customer_data
GROUP BY name, total_cuisines ORDER BY total_cuisines DESC LIMIT 5;

-- ========================================================================================
-- Question 9:	Which restaurant has a highest no. of dishes liked.
-- ========================================================================================

SELECT 
    name,
    LENGTH(dish_liked) - LENGTH(REPLACE(dish_liked, ',', '')) + 1 AS max_dishes_liked,
    LENGTH(cuisines) - LENGTH(REPLACE(cuisines, ',', '')) + 1 AS total_cuisines
FROM
    customer_data
GROUP BY name , max_dishes_liked, total_cuisines
ORDER BY max_dishes_liked DESC, total_cuisines ASC
LIMIT 5;

-- ========================================================================================
-- Question 10: Which restaurant has the lowest cost to rating value.
-- ========================================================================================

SELECT 
    name,
     ROUND(AVG(ratings), 1) AS ratings,
	 ROUND(AVG(votes), 0) AS votes,
     ROUND(AVG(cost), 0) AS cost
FROM
    customer_data
GROUP BY name
ORDER BY ratings DESC, cost, votes ASC
LIMIT 5;
