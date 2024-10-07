DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix (
    show_id VARCHAR(5),
    type VARCHAR(10),
    title VARCHAR(250),
    director VARCHAR(550),
    casts VARCHAR(1050),
    country VARCHAR(550),
    date_added VARCHAR(55),
    release_year INT,
    rating VARCHAR(15),
    duration VARCHAR(15),
    listed_in VARCHAR(250),
    description VARCHAR(550)
);
select * from netflix;
----Bussiness Problems
------Count the number of Movies vs TV Shows----
select type, count(*) from netflix group by type;
-----Find the most common rating for movies and TV shows----
select type, rating from
(select type, rating, count(*) as total_count, rank() over(partition by type order by count(*) desc) as ranking
 from netflix group by type, rating) as t1 where ranking = 1;
----- List all movies released in a specific year (e.g., 2020)------
select * from netflix where type = 'Movie' and release_year = '2020';
------Find the top 5 countries with the most content on Netflix-----
select country, count(show_id) as total_content from netflix group by country order by total_content desc limit 5;
-----Identify the longest movie---
select * from netflix where type = 'Movie' and duration = (select max(duration) from netflix);
-----Find content added in the last 5 years----
SELECT * FROM netflix WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= CURRENT_DATE - INTERVAL 5 YEAR;
----- Find all the movies/TV shows by director 'Rajiv Chilaka'!----
select * from netflix where director like 'Rajiv Chilaka';
-----List all TV shows with more than 5 seasons----
SELECT *, CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS season FROM netflix 
WHERE type = 'TV Show' AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;
------Find each year and the average numbers of content release by India on netflix----
select extract(year from str_to_date(date_added, '%M %d, %Y')) as year, count(*) as total, count(*)/
(select count(*) from netflix where country = 'India') * 100 as avg_content from netflix where 
country = 'India' group by year;
------List all movies that are documentaries----
select * from netflix where listed_in like "%documentaries%";
-----Find all content without a director----
select * from netflix where director is null;
----- Find how many movies actor 'Salman Khan' appeared in last 10 years!-----
select * from netflix where casts like '%Salman Khan%' and release_year > extract(year from current_date) - 10;
-------Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category----
with new_table as (select *, case when description like '%kill%' or description like '%violence%' then 'Bad_Film' 
else 'Good_Film' end category from netflix) select category, count(*) as total_cotent from new_table group
 by category;
 

------
