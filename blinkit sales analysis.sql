-- Analysis--
select count(*) from orders;
select round(sum(order_total),2) as rev from orders;
-- Joins--
SELECT customer.customer_name, COUNT(orders.order_id) AS total_orders, orders.payment_method FROM orders LEFT JOIN 
customer ON customer.customer_id = orders.customer_id GROUP BY customer.customer_name, orders.payment_method ORDER BY 
total_orders;
select * from orders, customer, order_item where orders.customer_id = customer.customer_id and round(order_item.order_id)
= orders.order_id;
select oi.id, count(oi.quantity) as total_qty, o.delivery_status, c.customer_name from orders o, customer c, order_item oi 
where o.customer_id = c.customer_id and round(oi.order_id) = o.order_id group by oi.id, o.delivery_status, c.customer_name
order by total_qty;
select c.customer_id, count(c.total_orders) as total, sum(oi.quantity*oi.unit_price) as total_rev from customer c join orders o 
on o.customer_id = c.customer_id join order_item oi on round(oi.order_id) = o.order_id group by c.customer_id
order by total, total_rev;
select * from orders, customer, order_item, products where orders.customer_id = customer.customer_id and 
round(order_item.order_id) = orders.order_id and order_item.product_id = round(products.product_id);
select p.product_name, p.category, sum(p.price) as rev, count(oi.quantity) as total from orders o join 
order_item oi on round(oi.order_id) = o.order_id join products p on oi.product_id = round(p.product_id) group by 
p.product_name, p.category order by rev, total;
-- Retrieve Customer Orders with Delivery Details and Feedback Sentiment:
select c.customer_id, c.customer_name, o.order_id, o.order_date, o.delivery_status, d.actual_time, cf.sentiment, 
cf.feedback_text from customer c join orders o on c.customer_id = o.customer_id join delivery d on o.order_id = 
d.order_id left join customer_feedbacks cf on o.order_id = cf.order_id order by o.order_date desc; 
-- Find Top 5 Customers by Total Revenue (Using Rank):
select c.customer_id, c.customer_name, round(sum(o.order_total),2) as total_rev, rank() over(order by round(
sum(o.order_total),2) desc) as ranking from customer c join orders o on c.customer_id = o.customer_id group by 
c.customer_id, c.customer_name limit 5;
-- . Find Top-Selling Products with Revenue and Rank:
select p.product_id, p.product_name, sum(oi.quantity) as total_qty, sum(oi.quantity * oi.unit_price) as total_rev,
rank() over(order by sum(oi.quantity * oi.unit_price) desc) as ranking from products p join order_item oi on 
round(p.product_id) = oi.product_id group by p.product_id, p.product_name order by total_rev desc;
-- Identify Customers with Most Orders and Their Feedback Sentiment:
select c.customer_id, c.customer_name, count(o.order_id) as total_orders, round(avg(cf.rating)) as avg_rating, 
row_number() over(order by count(o.order_id) desc) as ranking from customer c join orders o on c.customer_id = 
o.customer_id left join customer_feedbacks cf on o.order_id = cf.order_id group by c.customer_id, c.customer_name 
order by total_orders desc;
-- Get Total Orders, Revenue, and Feedback Sentiment Analysis by Area:
select c.area, count(o.order_id) as total_orders, round(sum(o.order_total),2) as total_rev, round(avg(cf.rating)) as avg_rating,
count(case when cf.sentiment = 'Negative' then 1 end) as negavtive_feedbacks from customer c join orders o 
on c.customer_id = o.customer_id left join customer_feedbacks cf on o.order_id = cf.order_id group by c.area order by
total_rev desc;
-- Analyze Delivery Performance Based on Distance and Delay:
SELECT d.delivery_partner_id, AVG(d.delivery_time_minutes) AS avg_delivery_time, AVG(d.distance_km) AS avg_distance,
COUNT(CASE WHEN d.delivery_status = 'Delayed' THEN 1 END) AS delayed_orders FROM delivery d GROUP BY d.delivery_partner_id
ORDER BY delayed_orders DESC, avg_delivery_time DESC;
-- Track Inventory Stock and Damaged Stock Trends
select i.product_id, p.product_name, sum(i.stock_received) as total_stock, sum(i.damaged_stock) as damaged_stock,
(sum(i.stock_received)-sum(i.damaged_stock)) as available_stock from inventory i join products p on i.product_id
= p.product_id group by i.product_id, p.product_name order by available_stock asc;
-- Retrieve Top 3 Products Sold by Each Category (Using ROW_NUMBER):
select category, product_id, product_name, total_quantity, ranking from (select p.category, p.product_id, p.product_name,
sum(oi.quantity) as total_quantity, row_number() over(partition by p.category order by sum(oi.quantity)desc) as ranking
from products p join order_item oi on round(p.product_id) = oi.product_id group by p.category, p.product_id, p.product_name)
ranked_products where ranking <= 3;
-- Find Customers with Orders Delivered Late Multiple Times (Using COUNT and HAVING):
select c.customer_id, c.customer_name, count(o.order_id) as late_orders from customer c join orders o on c.customer_id = 
o.customer_id where o.actual_delivery_time > o.promised_delivery_time group by c.customer_id, c.customer_name having
count(o.order_id)>1 order by late_orders desc;
-- Analyze Feedback Distribution and Average Rating by Product Category (Using Joins):
select p.category, count(cf.feedback_id) as feedback_count, avg(cf.rating) as avg_rating,
count(CASE WHEN cf.sentiment = 'Positive' THEN 1 END) AS positive_feedbacks,
COUNT(CASE WHEN cf.sentiment = 'Negative' THEN 1 END) AS negative_feedbacks
from products p join order_item oi on p.product_id = oi.product_id join orders o on oi.order_id = o.order_id
join customer_feedbacks cf on o.order_id = cf.order_id group by p.category order by feedback_count desc;
