
-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

-- SELECT film_title as name, release_year, MIN(worldwide_gross)
-- FROM specs as s
-- LEFT JOIN revenue as r
-- ON s.movie_id = r.movie_id
-- GROUP BY film_title, release_year, worldwide_gross
-- ORDER BY worldwide_gross ASC
-- LIMIT 1

-- ANSWER = Semi-Tough, released in 1977, is the lowest grossing movie with a gross of 37,187,139.


-- 2. What year has the highest average imdb rating?

-- SELECT s.release_year, AVG(r.imdb_rating)
-- FROM specs as s
-- LEFT JOIN rating AS r
-- ON s.movie_id = r.movie_id
-- GROUP BY release_year, r.imdb_rating
-- ORDER BY r.imdb_rating DESC
--LIMIT 1


-- ANSWER 2008 has the highest average imdb rating of 9.0.

-- select s.release_year, AVG(imdb_rating) as avg_imdb_rating
-- FROM specs as s
-- LEFT JOIN rating as r
-- USING (movie_id)
-- GROUP BY s.release_year, r.imdb_rating
-- ORDER BY r.imdb_rating DESC


-- 3. What is the highest grossing G-rated movie?

-- SELECT film_title, mpaa_rating, worldwide_gross
-- FROM specs as s
-- LEFT JOIN revenue as r
-- ON s.movie_id = r.movie_id
-- WHERE mpaa_rating = 'G'
-- ORDER BY worldwide_gross DESC
-- LIMIT 1

-- ANSWER The highest grossing G-Rated movie is Toy Story 4.

-- Which company distributed it?

-- SELECT film_title, mpaa_rating, company_name, worldwide_gross
-- FROM specs as s
-- LEFT JOIN revenue as r
-- ON s.movie_id = r.movie_id
-- LEFT JOIN distributors as d
-- ON s.domestic_distributor_id = d.distributor_id
-- WHERE mpaa_rating = 'G'
-- ORDER BY worldwide_gross DESC
-- LIMIT 1

-- ANSWER Toy Story 4 was distributed by Walt Disney.


-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

-- SELECT DISTINCT(d.company_name), COUNT(s.movie_id) as movie_count
-- FROM distributors as d
-- LEFT JOIN specs as s
-- ON d.distributor_id = s.domestic_distributor_id
-- GROUP BY d.company_name
-- ORDER BY movie_count DESC


-- 5. Write a query that returns the five distributors with the highest average movie budget.

-- SELECT d.company_name, ROUND(AVG(r.film_budget),0) as average_budget
-- FROM distributors as d
-- LEFT JOIN specs as s
-- ON d.distributor_id = s.domestic_distributor_id
-- LEFT JOIN revenue AS r
-- ON s.movie_id = r.movie_id
-- WHERE r.film_budget IS NOT NULL
-- GROUP BY d.company_name
-- ORDER BY average_budget DESC
-- LIMIT 5

-- 6a. How many movies in the dataset are distributed by a company which is not headquartered in California? 

-- SELECT d.headquarters, COUNT(s.movie_id) as count_of_not_hq_in_cali
-- FROM specs as s
-- LEFT JOIN distributors as d
-- ON s.domestic_distributor_id = d.distributor_id
-- WHERE d.headquarters NOT LIKE '%CA'
-- GROUP BY d.headquarters, s.movie_id

--ANSWER Only 2 movies in the dataset are distributed bya company, whose HQ is not in California.


--6b. Which of these movies has the highest imdb rating?

-- SELECT s.movie_id, s.film_title, r.imdb_rating
-- FROM specs as s
-- LEFT JOIN distributors as d
-- ON s.domestic_distributor_id = d.distributor_id
-- LEFT JOIN rating as r
-- USING (movie_id)
-- WHERE d.headquarters NOT LIKE '%CA'
-- GROUP BY s.movie_id, s.film_title, r.imdb_rating
-- ORDER BY r.imdb_rating DESC
-- LIMIT 1

--ANSWER Of all the movies distributed by a company whose HQ is not based in California, Dirty Dancing, has the highest IMDB rating.

--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

-- SELECT *
-- FROM
-- (SELECT ROUND(AVG(r.imdb_rating),2) as avg_imdb_rating_movies_lt_2hrs
-- FROM specs as s
-- LEFT JOIN rating as r
-- USING (movie_id)
-- WHERE (s.length_in_min/60) < 2
-- LIMIT 1)
-- CROSS JOIN
-- (SELECT ROUND(AVG(r.imdb_rating),2) as avg_imdb_rating_movies_gte_2hrs
-- FROM specs as s
-- LEFT JOIN rating as r
-- USING (movie_id)
-- WHERE (s.length_in_min/60) >= 2
-- LIMIT 1);


--ANSWER Movies over 2 hours have a higher average IMDB rating.
