select * from pizza_sales;
select sum(total_price) as total_revenue from pizza_sales;
select sum(total_price) / count(distinct order_id) as avg_order_value
 from pizza_sales;
 select sum(quantity) as total_pizzas_sold from pizza_sales;
 select count(distinct order_id) as total_orders from pizza_sales;
 select cast(sum(quantity) as decimal(10,2))/ 
 cast(count(distinct order_id) as decimal(10,2)) as avg_pizzas_per_order
 from pizza_sales;
 -----daily trend for total orders-----
 select  DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) as order_day , count(distinct order_id) 
 as total_orders from  pizza_sales group by order_day;
 ------monthly trends for total orders-----
 select MONTHNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) as month_name ,
 count(distinct order_id) as total_orders from pizza_sales 
 group by month_name order by total_orders desc;
 -----percenatge of sales by pizza category----
 select pizza_category, sum(total_price)*100 /(select sum(total_price)
 from pizza_sales) as pct from pizza_sales
 group by pizza_category;
 select pizza_category, sum(total_price)*100 /(select sum(total_price)
 from pizza_sales where month(order_date) = 1) as pct from 
 pizza_sales where month(order_date) = 1 group by pizza_category;
 --------percenatge of sales by pizza size----
 select pizza_size, sum(total_price)*100 /(select sum(total_price)
 from pizza_sales) as pct from pizza_sales
 group by pizza_size order by pct desc;
 -----top and bottom 5 best and worst sellers----
 select pizza_name, sum(total_price) as total_revenue from pizza_sales
 group by pizza_name order by sum(total_price) desc limit 5;
 select pizza_name, sum(total_price) as total_revenue from pizza_sales
 group by pizza_name order by sum(total_price) asc limit 5;
 select pizza_name, sum(quantity) as total_quantity from pizza_sales
 group by pizza_name order by total_quantity desc limit 5;
 select pizza_name, sum(quantity) as total_quantity from pizza_sales
 group by pizza_name order by total_quantity asc limit 5;
 select pizza_name, count(distinct order_id) as total_order 
 from pizza_sales
 group by pizza_name order by total_order desc limit 5;
 select pizza_name, count(distinct order_id) as total_order 
 from pizza_sales
 group by pizza_name order by total_order asc limit 5;