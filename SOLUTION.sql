drop table if exists netflix;

create table netflix (
show_id varchar(6),
type_data	varchar(100),
title	varchar(150),
director	varchar(208),
casts varchar(1000),
country varchar(150),	
date_added	varchar(50),
release_year int,
rating	varchar(10),
duration	varchar(15),
listed_in	varchar(150),
description varchar(250)
);


select * from netflix;
select distinct type_data from netflix;

--1. count the number of movies vs TV shows

select  * from netflix;

select type_data, count(*) as total_content from netflix
group by type_data;

--2. Find the most common rating for movies and TV shows

select 
type_data, rating, count(*)
from netflix
group by type_data, rating
order by 1,3 desc;


--3. List all movies released in a specific year

select* from netflix
where type_data = 'Movie' 
and release_year = 2020;

4. Find the top 5 countries with the most content on netflix

select 
unnest(string_to_array(country,',')) as new_country,
count(show_id) as total_content
from netflix
group by 1
order by total_content desc
limit 5;

5. identify the longest movie?

select* from netflix
where type_data = 'movie'
and duration = (select max(duration) from netflix);

6. Find the content added in the last 5 years


select *
from netflix
where  to_date(date_added, 'month DD,YYYY') >= current_date - interval '5 years'
;

7. Find all the movies/TN show by director 'Rajiv Chilaka'!

Select * from netflix
where director like '%Rajiv Chilaka

8. List all TV shows with more than 5 seasons

select *from netflix
where type_data = 'TV Show'
and
split_part(duration, ' ' , 1) :: numeric> 5
order by split_part(duration, ' ' , 1) :: numeric desc;


9.  Count the number of content items in each genre

select 
unnest(string_to_array(listed_in,',')) as genre,
count(show_id) as total_content
from netflix
group by 1;


select
unnest(String_to_array(listed_in,',')) as genre,
count(show_id) as total_content
from netflix
group by 1;



10. Find each year and the average numbers of content release by India on netflix, return
top 5 year with highest avg content release

select*from netflix

select count(*) from netflix where country = 'India'

select 
extract(year from to_date(date_added, 'Month DD, YYYY')) as year,
count(*) as yearly_content,
count(*)::numeric/(select count(*) from netflix where country = 'India')::numeric* 100 as avg_content 
from netflix
where country = 'India'
group by 1;



11. List all the movies that are documentaries

select * from netflix
where
listed_in Ilike '%documentaries%';

12. Find all content without a director

select * from netflix
where director is null;

13. Find how many movies actor 'Salman Khan' appeared in last 10 years.

select * from netflix
where
casts ilike '%Salman Khan%'
and
release_year > extract (year from current_date) -10

14. Find the top 10 actors who appeared in the highest number of movies produced in India.

select 
unnest(string_to_array(casts, ',')) as actor,
count(*) as number_of_content
from netflix
where country ilike '%india'
group by 1
order by 2 desc
limit 10;

15. categorize the content based on the presence of the keywords
'Kill' and 'violence' in the description field. label content containing these
keywords as 'Bad' and all other content as 'good'. Count how many
fall into each category.

WITH NEW_TABLE
AS
(
select 
*,
case
when
	description ilike '%kill%'
	or 
	description ilike '%violence%'
	then 'bad_content'
	else 'good_content'
end category
from netflix
)
SELECT 
CATEGORY,
COUNT(*) AS TOTAL_CONTENT
FROM NEW_TABLE
GROUP BY 1;







