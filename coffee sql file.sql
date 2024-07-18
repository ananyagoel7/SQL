select * from coffee_shop_sales;

update coffee_shop_sales set transaction_date = str_to_date(transaction_date, "%d-%m-%Y");
alter table coffee_shop_sales modify column transaction_date DATE;
describe coffee_shop_sales;
update coffee_shop_sales set transaction_time = str_to_date(transaction_time, "%H:%i:%s");
alter table coffee_shop_sales modify column transaction_time TIME;
-----total sales analysis----
select sum(unit_price * transaction_qty) as total_sales from coffee_shop_sales where month(transaction_date) = 5;
select round(sum(unit_price * transaction_qty),1) as total_sales from coffee_shop_sales where month(transaction_date) = 3;
select month(transaction_date) as month, round(sum(unit_price * transaction_qty)) as total_sales, (sum(unit_price * 
transaction_qty) - lag(sum(unit_price * transaction_qty),1) over (order by month(transaction_date)))/
 lag(sum(unit_price * transaction_qty),1) over (order by month(transaction_date)) * 100 as mom_inc_percentage
 from coffee_shop_sales where month(transaction_date) in (4, 5) group by month(transaction_date) order by 
 month(transaction_date);
 ------total order analysis-----
 select count(transaction_id) as total_orders from coffee_shop_sales where month(transaction_date) = 5;
 select month(transaction_date) as month, round(count(transaction_id)) as total_orders, (count(transaction_id) 
 - lag(count(transaction_id),1) over (order by month(transaction_date)))/
 lag(count(transaction_id),1) over (order by month(transaction_date)) * 100 as mom_inc_percentage
 from coffee_shop_sales where month(transaction_date) in (4, 5) group by month(transaction_date) order by 
 month(transaction_date);
 ----total qty sold analysis----
 select sum(transaction_qty) as total_qty_sold from coffee_shop_sales where month(transaction_date) = 5;
 select month(transaction_date) as month, round(sum(transaction_qty)) as total_qty_sold, (sum(
transaction_qty) - lag(sum(transaction_qty),1) over (order by month(transaction_date)))/
 lag(sum( transaction_qty),1) over (order by month(transaction_date)) * 100 as mom_inc_percentage
 from coffee_shop_sales where month(transaction_date) in (4, 5) group by month(transaction_date) order by 
 month(transaction_date);
 -----------------
 select concat(round(sum(unit_price * transaction_qty)/1000,1), 'K') as total_sales, 
 concat(round(sum(transaction_qty)/1000,1), 'K') as total_qty_sold, concat(round(count(transaction_id)/1000,1), 'K') 
 as total_orders from coffee_shop_sales where transaction_date = "2023-05-18";
 ------sales analysis by weekdays and weekends-----
 select 
       case when dayofweek(transaction_date) in (1, 7) then "Weekends"
       else "Weekdays"
       end as day_type,
       concat(round(sum(unit_price * transaction_qty)/1000,1), 'K') as total_sales from coffee_shop_sales where 
       month(transaction_date) = 5 group by day_type;
------sales analysis by store location----
select store_location, concat(round(sum(unit_price * transaction_qty)/1000,2), 'K')as total_sales from 
coffee_shop_sales where month(transaction_date) = 5 group by store_location order by total_sales desc;
------average sales-----
select concat(round(avg(total_sales)/1000,1), 'K') as avg_sales from (select sum(unit_price * transaction_qty)
as total_sales from coffee_shop_sales where month (transaction_date) = 5 group by transaction_date) as internal_query;
select day(transaction_date) as day_of_month, sum(unit_price * transaction_qty) as total_sales from coffee_shop_sales
where month(transaction_date) = 5 group by day_of_month order by day_of_month desc;
select day_of_month, 
       case when total_sales > avg_sales then 'Above Average'
       when total_sales < avg_sales then 'Below Average'
       else 'Average'
       end as sales_status, total_sales from (select day(transaction_date) as day_of_month, sum(unit_price * 
       transaction_qty) as total_sales ,avg(sum(unit_price * transaction_qty)) over() as avg_sales from 
       coffee_shop_sales where month(transaction_date) = 5 group by day_of_month) as sales_data order by 
       day_of_month desc;
-------sales analysis by product category---
select product_category, sum(unit_price * transaction_qty) as total_sales from coffee_shop_sales
where month(transaction_date) = 5 group by product_category order by total_sales desc;
-----top 10 product by sales----
select product_type, sum(unit_price * transaction_qty) as total_sales from coffee_shop_sales
where month(transaction_date) = 5 group by product_type order by total_sales desc limit 10;
--------sales analysis by days and hours----
select sum(unit_price * transaction_qty) as total_sales ,sum(transaction_qty) as total_qty_sold , count(*) as total_orders
 from coffee_shop_sales where month(transaction_date) = 5 and dayofweek(transaction_date) = 2 and hour(transaction_time)
 = 8;
 select hour(transaction_time) as hour_of_day, sum(unit_price * transaction_qty) as total_sales from coffee_shop_sales where
 month(transaction_date) = 5 group by hour_of_day order by hour_of_day;
 select case 
           when dayofweek(transaction_date) = 2 then 'Monday'
           when dayofweek(transaction_date) = 3 then 'Tuesday'
           when dayofweek(transaction_date) = 4 then 'Wednesday'
           when dayofweek(transaction_date) = 5 then 'Thursday'
           when dayofweek(transaction_date) = 6 then 'Friday'
           when dayofweek(transaction_date) = 7 then 'Saturday'
           else 'Sunday'
           end day_of_week, round(sum(unit_price * transaction_qty)) as total_sales from coffee_shop_sales 
           where month(transaction_date) = 5 group by day_of_week;
           
