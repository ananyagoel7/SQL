-- Data Cleaning --
update blinkit_data set Item_Fat_Content = case
        when Item_Fat_Content in ('LF', 'low fat') then 'Low Fat'
        when Item_Fat_Content = 'reg' then 'Regular'
        else Item_Fat_Content end;
        
-- KPI's --
-- Total Sales --
select round(sum(Total_Sales) / 1000000.0, 2) as Total_Sales_Million from blinkit_data;

-- Average Sales --
select round(avg(Total_Sales) / 1000000.0, 2) as avg_sales from blinkit_data;

-- No of Items --
select count(*) as no_of_items from blinkit_data;

-- Average Rating --
select round(avg(Rating) / 1000000.0, 2) as avg_rating from blinkit_data;

-- Total sales by fat content --
select round(sum(Total_Sales), 2) as Total_Sales from blinkit_data group by Item_Fat_Content;

-- Total sales by item type --
select round(sum(Total_Sales), 2) as Total_Sales from blinkit_data group by Item_Type order by Total_Sales desc;

-- Fat content by outlet for total sales --
SELECT Outlet_Location_Type,
    coalesce(sum(case when Item_Fat_Content = 'Low Fat' then Total_Sales else 0 end), 0) as Low_Fat,
    coalesce(sum(case when  Item_Fat_Content = 'Regular' then Total_Sales else 0 end), 0) as Regular
from blinkit_data group by Outlet_Location_Type order by Outlet_Location_Type;

-- Total sales by outlet establishment --
select Outlet_Establishment_Year, round(sum(Total_Sales), 2) as Total_Sales from blinkit_data
group by Outlet_Establishment_Year order by Outlet_Establishment_Year;


