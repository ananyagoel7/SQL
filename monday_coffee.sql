----Reports & Data Analysis
-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?
select city_name, round((population*0.25)/1000000, 2) as coffee_consumers_in_millions, city_rank from city order by 
coffee_consumers_in_millions desc;
-- -- Q.2 Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
select ci.city_name, sum(s.total) as total_rev  from sales as s join customers as c on s.customer_id = c.customer_id join city as ci on
ci.city_id = c.city_id where extract(Year from s.sale_date) = 2023 and extract(quarter from s.sale_date) = 4 group by 
ci.city_name order by total_rev desc;
--- Q.3 Sales Count for Each Product
-- How many units of each coffee product have been sold?
select p.product_name, count(s.sale_id) as total_orders from products as p left join sales as s on 
s.product_id  = p.product_id group by p.product_name order by total_orders desc;
-- Q.4 Average Sales Amount per City
-- What is the average sales amount per customer in each city?
SELECT ci.city_name, SUM(s.total) AS total_revenue, count(DISTINCT s.customer_id) AS total_cx, ROUND(SUM(s.total) / 
COUNT(DISTINCT s.customer_id), 2) AS avg_sale_pr_cx FROM sales AS s JOIN customers AS c ON s.customer_id = c.customer_id
JOIN city AS ci ON ci.city_id = c.city_id GROUP BY ci.city_name ORDER BY total_revenue DESC;
-- Q.5
-- City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)
with city_table as (select city_name, round((population * 0.25)/1000000, 2) as coffee_consumers from city),
 customer_table as (select ci.city_name, count(distinct c.customer_id) as unique_cx from sales as s join 
customers as c on c.customer_id = s.customer_id join city as ci on ci.city_id = c.city_id group by ci.city_name)
select ct.city_name, ct.coffee_consumers, cit.unique_cx from city_table as ct join customer_table as cit on cit.city_name = 
ct.city_name;
 -- Q6
-- Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?
select * from 
(select ci.city_name, p.product_name, count(s.sale_id) as total_orders, dense_rank() over(partition by ci.city_name 
order by count(s.sale_id) desc) as ranking from sales as s join products as p on s.product_id
= p.product_id join customers as c on c.customer_id = s.customer_id join city as ci on ci.city_id = c.city_id 
group by ci.city_name, p.product_name ) as t1 where ranking <= 3;
-- Q.7
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?
select ci.city_name, count(distinct c.customer_id) as unique_cx from city as ci left join customers as c 
on c.city_id = ci.city_id join sales as s on s.customer_id = c.customer_id
where s.product_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 11, 12, 13, 14) group by ci.city_name order by unique_cx desc;
-- Q.8
-- Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer
with city_table as (
SELECT ci.city_name, SUM(s.total) AS total_revenue, count(DISTINCT s.customer_id) AS total_cx, ROUND(SUM(s.total) / 
COUNT(DISTINCT s.customer_id), 2) AS avg_sale_pr_cx FROM sales AS s JOIN customers AS c ON s.customer_id = c.customer_id
JOIN city AS ci ON ci.city_id = c.city_id GROUP BY ci.city_name ORDER BY total_revenue DESC),
city_rent as (select city_name, estimated_rent from city)
select cr.city_name, cr.estimated_rent, ct.total_cx, ct.avg_sale_pr_cx, round((cr.estimated_rent/ct.total_cx) ,2)
as avg_rent_pr_cx from city_rent as cr join city_table as ct on cr.city_name = ct.city_name order by avg_rent_pr_cx desc;
-- Q.9
-- Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city
with monthly_sales as (
select ci.city_name, extract(month from sale_date) as month, extract(year from sale_date) as Year, sum(s.total) as 
total_sale from sales as s join customers as c on c.customer_id = s.customer_id join city as ci on ci.city_id = 
c.city_id group by ci.city_name, month, Year order by ci.city_name, Year, month),
growth_ratio as (
select city_name, month, Year, total_sale as cr_month_sale, lag(total_sale, 1) over(partition by city_name order by
Year, month) as last_month_sale from monthly_sales)
select city_name, month, Year, cr_month_sale, last_month_sale, round(cr_month_sale - last_month_sale / last_month_sale*100 , 2) 
as growth_precent from growth_ratio where last_month_sale is not null;
 -- Q.10
-- Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers,
-- estimated coffee consumer
with city_table as (
SELECT ci.city_name, SUM(s.total) AS total_revenue, count(DISTINCT s.customer_id) AS total_cx, ROUND(SUM(s.total) / 
COUNT(DISTINCT s.customer_id), 2) AS avg_sale_pr_cx FROM sales AS s JOIN customers AS c ON s.customer_id = c.customer_id
JOIN city AS ci ON ci.city_id = c.city_id GROUP BY ci.city_name ORDER BY total_revenue DESC),
city_rent as (select city_name, estimated_rent, round((population* 0.25)/1000000, 2)as estimated_coffee_consumer from city)
select cr.city_name, ct.total_revenue, cr.estimated_rent as total_rent, ct.total_cx, cr.estimated_coffee_consumer,
ct.avg_sale_pr_cx, round((cr.estimated_rent/ct.total_cx) ,2) as avg_rent_pr_cx from city_rent as 
cr join city_table as ct on cr.city_name = ct.city_name order by avg_rent_pr_cx desc;

