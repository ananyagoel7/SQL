-- Query 1: Retrieve all orders for a specific customer
select o.OrderID, o.OrderDate, o.TotalAmount, oi.ProductID, p.ProductName, oi.Quantity, oi.Price from orders o join
orderitems oi on oi.OrderID = o.OrderID join products p on oi.ProductID = p.ProductID where o.CustomerID = 1;

-- Query 2: Find the total sales for each product
select p.ProductID, p.ProductName, sum(oi.Quantity * oi.Price) as total_sales from orderitems oi join products p on
oi.ProductID = p.ProductID group by p.ProductID, p.ProductName order by total_sales desc;

-- Query 3: Calculate the average order value
select round(avg(TotalAmount),2) as avg_order_value from orders;

-- Query 4: List the top 5 customers by total spending
select CustomerID, FirstName, LastName, TotalSpent, rn from (select c.CustomerID, c.FirstName, c.LastName, sum(
o.TotalAmount) as TotalSpent, row_number() over(order by sum(o.TotalAmount) desc) as rn from customers c join orders o
on c.CustomerID = o.CustomerID group by c.CustomerID, c.FirstName, c.LastName) sub where rn <= 5;

-- Query 5: Retrieve the most popular product category
select CategoryID, CategoryName, TotalQtySold, rn from (select c.CategoryID, c.CategoryName, sum(oi.Quantity) as
TotalQtySold, row_number() over(order by sum(oi.Quantity) desc) as rn from orderitems oi join products p on 
oi.ProductID = p.ProductID join categories c on p.CategoryID = c.CategoryID group by c.CategoryID, c.CategoryName) 
sub where rn = 1;

-- Query 6: List all products that are out of stock, i.e. stock = 0
select * from products where Stock = 0;
select ProductID, ProductName, Stock from products where Stock = 0;
-- with category name
select p.ProductID, p.ProductName, c.CategoryName, p.Stock from products p join categories c on p.CategoryID = 
c.CategoryID where Stock = 0;

-- Query 7: Find customers who placed orders in the last 30 days
select c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone from customers c join orders o on c.CustomerID = 
o.CustomerID where o.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Query 8: Calculate the total number of orders placed each month
select year(OrderDate) as orderyear, month(OrderDate) as ordermonth, count(OrderID) as total_orders from orders 
group by orderyear, ordermonth order by total_orders desc;

-- Query 9: Retrieve the details of the most recent order
select o.OrderID, o.OrderDate, o.TotalAmount, c.FirstName, c.LastName from orders o join customers c on o.CustomerID = 
c.CustomerID order by o.OrderDate desc limit 1;

-- Query 10: Find the average price of products in each category
select c.CategoryID, c.CategoryName, avg(p.Price) as avg_price from categories c join products p on c.CategoryID =
p.ProductID group by c.CategoryID, c.CategoryName;

-- Query 11: List customers who have never placed an order
select c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, o.OrderID, o.TotalAmount from customers c left outer join 
orders o on c.CustomerID = o.CustomerID where o.OrderID is null;

-- Query 12: Retrieve the total quantity sold for each product
select p.ProductID, p.ProductName, sum(oi.Quantity) as TotalQtySold from products p join orderitems oi on oi.ProductID = 
p.ProductID group by p.ProductID, p.ProductName order by TotalQtySold;

-- Query 13: Calculate the total revenue generated from each category
select c.CategoryID, c.CategoryName, sum(oi.Quantity * oi.Price) as total_rev from orderitems oi join products p on 
oi.ProductID = p.ProductID join categories c on c.CategoryID = p.CategoryID group by c.CategoryID, c.CategoryName
order by total_rev desc;

-- Query 14: Find the highest-priced product in each category
select c.CategoryID, c.CategoryName, p1.ProductID, p1.ProductName, p1.Price from categories c join products p1 on 
p1.CategoryID = c.CategoryID where p1.Price = (select max(p2.Price) from products p2 where p2.CategoryID = p1.CategoryID)
order by p1.Price desc;

-- Query 15: Retrieve orders with a total amount greater than a specific value (e.g., $500)
select o.OrderID, c.CustomerID, c.FirstName, c.LastName, o.TotalAmount from orders o join customers c on o.CustomerID = 
c.CustomerID where o.TotalAmount >= 49.99 order by o.TotalAmount desc;

-- Query 16: List products along with the number of orders they appear in
select p.ProductID, p.ProductName, count(oi.OrderID) as order_count from products p join orderitems oi on oi.ProductID = 
p.ProductID group by p.ProductID, p.ProductName order by order_count desc;

-- Query 17: Find the top 3 most frequently ordered products
select p.ProductID, p.ProductName, count(oi.OrderID) as order_count from orderitems oi join products p on 
oi.ProductID = p.ProductID group by p.ProductID, p.ProductName order by order_count desc limit 3;

-- Query 18: Calculate the total number of customers from each country
select Country, count(CustomerID) as total_customers from customers group by Country order by total_customers desc;

-- Query 19: Retrieve the list of customers along with their total spending
select c.CustomerID, c.firstName, c.LastName, sum(o.TotalAmount) as total_spending from customers c join orders o on
c.CustomerID = o.CustomerID group by c.CustomerID, c.firstName, c.LastName order by total_spending desc;

-- Query 20: List orders with more than a specified number of items (e.g., 5 items)
select o.OrderID, c.CustomerID, c.firstName, c.LastName, count(oi.OrderItemID) as total_items from orders o join 
orderitems oi on o.OrderID = oi.OrderID join customers c on o.CustomerID = c.CustomerID group by o.OrderID, 
c.CustomerID, c.firstName, c.LastName having count(oi.OrderItemID) >= 1 order by total_items;