select s.customer_id, sum(m.price) as total_spent from sales s join menu m on s.product_id = m.product_id group 
by s.customer_id;
select s.customer_id, count(distinct s.order_date) as days_visited from sales s group by s.customer_id;
with customer_first_purchase as (select s.customer_id, min(s.order_date) as first_purchase_date from sales s group by 
s.customer_id) 
select cfp.customer_id, cfp.first_purchase_date, m.product_name from customer_first_purchase cfp join sales s on s.customer_id
 = cfp.customer_id and cfp.first_purchase_date = s.order_date join menu m on m.product_id = s.product_id;
 select m.product_name, count(*) as total_purchased from sales s join menu m on s.product_id = m.product_id group by
 m.product_name order by total_purchased desc limit 1;
 with customer_popularity as (select s.customer_id, m.product_name, count(*) as purchased_count, row_number() 
 over (partition by s.customer_id order by count(*) desc) as rank_no from sales s join menu m on 
 s.product_id = m.product_id group by s.customer_id, m.product_name)
 select cp.customer_id, cp.product_name, cp.purchased_count from customer_popularity cp where rank_no = 1;
 with first_purchase_after_membership as (select s.customer_id, min(s.order_date) as first_purchase_date from 
 sales s join members mb on s.customer_id = mb.customer_id where s.order_date >= mb.join_date group by s.customer_id)
 select fpam.customer_id, m.product_name from first_purchase_after_membership fpam join sales s on s.customer_id
 = fpam.customer_id and fpam.first_purchase_date = s.order_date join menu m on s.product_id = m.product_id;
 with last_purchase_before_membership as (select s.customer_id, max(s.order_date) as last_purchase_date from 
 sales s join members mb on s.customer_id = mb.customer_id where s.order_date < mb.join_date group by s.customer_id)
 select lpbm.customer_id, m.product_name from last_purchase_before_membership lpbm join sales s on s.customer_id
 = lpbm.customer_id and lpbm.last_purchase_date = s.order_date join menu m on s.product_id = m.product_id;
 select s.customer_id, count(*) as total_items, sum(m.price) as total_spent from sales s join menu m on s.product_id = 
 m.product_id join members mb on s.customer_id = mb.customer_id where s.order_date < mb.join_date group by 
 s.customer_id;
 select s.customer_id, sum(
 case when m.product_name = 'sushi' then m.price*20
 else m.price*10 end) as total_points from sales s join menu m on s.product_id = m.product_id group by s.customer_id;
 select s.customer_id, sum(
 case when s.order_date between mb.join_date and date_add(mb.join_date, interval 7 day) then m.price*20 
 when m.product_name = 'sushi' then m.price*20 
 else m.price*100 end) as total_points from sales s join menu m on s.product_id = m.product_id left join members mb on
 s.customer_id = mb.customer_id where s.customer_id  in ('A', 'B') and s.order_date <= '2021-01-31' group by s.customer_id;
 select s.customer_id, s.order_date, m.product_name, m.price, case when s.order_date >= mb.join_date then 'Y' else 'N'
 end as member_yn from sales s join menu m on s.product_id = m.product_id left join members mb on s.customer_id = 
 mb.customer_id order by s.customer_id, s.order_date;
 with customers_data as (select s.customer_id, s.order_date, m.product_name, m.price, case when s.order_date < mb.join_date then 'N'
 when s.order_date >= mb.join_date then 'Y' else 'N' end as member_yn from sales s join members mb on s.customer_id
 = mb.customer_id join menu m on s.product_id = m.product_id)
 select *, case when member_yn = 'N' then null 
 else rank() over(partition by customer_id, member_yn order by order_date) end as ranking from customers_data order by 
 customer_id, order_date;
 
 