--For a high-level overview of the hotels, 
--provide us the top 5 most voted hotels in the delivery category.
select distinct name, votes, rating, location
from zomato
where type like '%Delivery%'
order by votes desc
limit 5;

--The rating of a hotel is a key identifier in determining a restaurant’s performance. 
--Hence for a particular location called Banashankari find out
--the top 5 highly rated hotels in the delivery category.
select name, rating,location, type
from zomato z 
where location = 'Banashankari' and type = 'Delivery'
order by rating desc
limit 5;


--compare the ratings of the cheapest and most expensive rhotels in Indiranagar

select cheapest_rest,rating_max_cheapest, most_expensive_rest, rating_max_most_expensive
from (select max(rating)as rating_max_cheapest, name as cheapest_rest from zomato where location = "Indiranagar" 
and approx_cost = (select min(approx_cost) as cheapest
from zomato where location = "Indiranagar"))zmin
join (select max(rating)as rating_max_most_expensive,  name as most_expensive_rest from zomato where location = "Indiranagar"
and approx_cost = (select max(approx_cost) as most_expensive
from zomato where location = "Indiranagar"))zmax;

--Online ordering of food has exponentially increased over time. 
--Compare the total votes of restaurants that provide online ordering services 
--and those who don’t provide online ordering service.
select sum(votes) as total_votes, online_order 
from zomato 
where online_order='Yes'
UNION 
select sum(votes) as total_votes, online_order 
from zomato 
where online_order='No'
group by online_order ;

--Number of votes defines how much the customers are involved with the service provided by the restaurants 
--For each Restaurant type, find out the number of restaurants, total votes, and average rating. 
--Display the data with the highest votes on the top
--( if the first row of output is NA display the remaining rows).
select type,count(type) as number_of_restaurants,sum(votes) as total_votes, AVG(rating) as avg_rating
from zomato
where type!='NA' 
group by type
order by total_votes desc;

--What is the most liked dish of the most-voted restaurant on Zomato
--(as the restaurant has a tie-up with Zomato, the restaurant compulsorily provides 
--online ordering and delivery facilities).
select name,dish_liked,max(rating) as max_rating,max(votes) as max_votes
from zomato
group by dish_liked, name
order by max_rating desc, max_votes desc
limit 1;

--To increase the maximum profit, Zomato is in need to expand its business.
--For doing so Zomato wants the list of the top 15 restaurants which have min 150 votes, 
--have a rating greater than 3, and is currently not providing online ordering. 
--Display the restaurants with highest votes on the top.
select distinct name, votes, rating, online_order, rest_type, dish_liked, cuisines
from zomato
where votes >= 150 and rating > 3.0 and online_order ='No'
order by votes desc
limit 15;









