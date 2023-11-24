/* 
Netflix Data Exploration Project using SQL Server and Tableau Desktop
Teuku Abuzar Akbar
November 24, 2023
*/

-- Check all the data frame.
SELECT * 
FROM netflix_SQL..netflix_titles$

-- Verify the quantity of movies and TV shows within the entire dataset, along with the respective percentages for each type.
SELECT
  type,
  COUNT(type) AS total,
  COUNT(type) * 100.0 / (SELECT COUNT(*) FROM netflix_SQL..netflix_titles$ 
  WHERE type <> ' ') AS percentage
FROM netflix_SQL..netflix_titles$
WHERE  type <> ' '
GROUP BY type;

-- Top 10 country producing movie and tv show
SELECT 
	country,
	count(country) as total_per_country 
FROM netflix_SQL..netflix_titles$
WHERE country <> ' ' 
GROUP BY country 
ORDER BY total_per_country DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY

-- Top 10 director producing movie and tv show.
SELECT 
	director,
	count(director) as total_producing 
FROM netflix_SQL..netflix_titles$
WHERE director <> ' ' 
GROUP BY director 
ORDER BY total_producing DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY

-- Check unique Rating
SELECT DISTINCT(rating) 
FROM netflix_SQL..netflix_titles$ 
WHERE rating <> ' '

-- Total Movie & TV Show per Rating
SELECT rating, count(rating) total_rating 
FROM netflix_SQL..netflix_titles$ 
WHERE rating <> ' '
GROUP BY rating 
ORDER BY total_rating DESC
OFFSET 0 ROWS
FETCH NEXT 14 ROWS ONLY

--Total Movie & TV Show per Genre
SELECT listed_in, count(listed_in) total 
FROM netflix_SQL..netflix_titles$
GROUP BY listed_in 
ORDER BY total DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

-- Total Movie and TV Show per Release Year
SELECT release_year , COUNT(release_year) total_movie 
FROM netflix_SQL..netflix_titles$
WHERE release_year is not null 
GROUP BY release_year 
ORDER BY release_year DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

