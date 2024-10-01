------create table
create table retail_sales(
transaction_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(10),
age int,
category varchar(15),
quantity int,
price_per_unit float,
cogs float,
total_sale float)
select * from retail_sales;
-------Data Cleaning-----
select * from retail_sales where transaction_id is null or sale_date is null or sale_time is null or customer_id
is null or gender is null or category is null or quantity is null or cogs is null or total_sale is null;
delete from retail_sales where transaction_id is null or sale_date is null or sale_time is null or customer_id
is null or gender is null or category is null or quantity is null or cogs is null or total_sale is null;
------Data Exploration----
-----how many sales we have---
select count(*) as total_sales from retail_sales;
-----how many unique customers we have---
select count(distinct customer_id) from retail_sales;
-----how many category we have----
select count(distinct category) from retail_sales;
---------Data Analysis-----
-----Write a SQL query to retrieve all columns for sales made on '2022-11-05'----
select * from retail_sales where sale_date = '2022-11-05';
------Write a SQL query to retrieve all transactions where the category is 'Beauty' and the quantity sold is
 more than 3 in the month of Dec-2022------
SELECT * FROM retail_sales WHERE category = 'Beauty' AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-12' AND quantity >= 3;
-------Write a SQL query to calculate the total sales (total_sale) for each category.----
select category, sum(total_sale) as net_sales, count(*) as total_orders from retail_sales group by category;
-----Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.----
select round(avg(age),2) as avg_age from retail_sales where category = 'Beauty';
----Write a SQL query to find all transactions where the total_sale is greater than '1000'.----
select * from retail_sales where total_sale > 1000;
-----Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.-----
select category, gender, count(transaction_id) as total_transactions from retail_sales group by category, gender;
------Write a SQL query to calculate the average sale for each month. Find out best selling month in each year----
select * from (SELECT EXTRACT(YEAR FROM sale_date) AS year, EXTRACT(MONTH FROM sale_date) AS month, ROUND(AVG(total_sale), 0) 
AS avg_sale, RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as sale_rank
FROM retail_sales GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)) as t1 where sale_rank = 1;
------Write a SQL query to find the top 5 customers based on the highest total sales ----
select customer_id, sum(total_sale) as total_sales from retail_sales group by customer_id order by total_sales desc limit 5;
-----Write a SQL query to find the number of unique customers who purchased items from each category.----
select category, count(distinct customer_id) as customers from retail_sales group by category order by customers desc;
-----Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)----
with hourly_sale as (select *, case when extract(hour from sale_time) < 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening' end as shift from retail_sales) select shift, count(transaction_id) as total_orders from hourly_sale 
group by shift;
 