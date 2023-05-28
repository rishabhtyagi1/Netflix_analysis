Create table movies(
	show_id varchar Primary key,
	type varchar,
	title varchar,
	director varchar,
	"cast" varchar,
	country varchar,
	date_added varchar,
	release_year varchar,
	rating varchar,
	duration varchar,
	listed_in varchar,
	description varchar
)

Select * from movies;

COPY movies FROM 'C:\Program Files\PostgreSQL\show_id,type,title,director,cast,co.txt' WITH (FORMAT csv);
---Is there any missing data? Deal with them accordingly.
Delete from movies where date_added is null;

---Using the ‘date_added’ column a new column called ‘year_added’ that only has the year the title was added.
ALTER TABLE movies 
ALTER COLUMN date_added TYPE date USING date_added::date;

ALTER TABLE movies 
ADD COLUMN year_added int;

UPDATE movies 
SET year_added = EXTRACT(YEAR FROM date_added);

---Using the ‘date_added’ column a new column called ‘month_added’ that only has the month the title was added.
ALTER TABLE movies 
ADD COLUMN month_added int;

UPDATE movies 
SET month_added = EXTRACT(YEAR FROM date_added);

---Check the data types. Anything look odd? Adjust accordingly.
Select * from movies;

---What is the most popular release year for movies on Netflix?
Select release_year, count(release_year) as total_release 
from movies
group by release_year
order by total_release desc
limit 1;

---What year did Netflix add the most content to its platform?
Select year_added, count(year_added) as movies_added
from movies 
group by year_added
order by movies_added desc
limit 1;

---What is the movie with the longest title in the dataset?
SELECT title, LENGTH(title) AS longest_title
FROM movies
order by longest_title desc
limit 1;

---What are the top 5 most popular movie genres?
Select listed_in, count(listed_in) total_movies
from movies
group by listed_in
order by total_movies desc
limit 5;


