create database ola;
select * from bookings;
--- Analysis---
-- Q.1 Retrieve all successful bookings:--
create view Successful_Bookings as select * from bookings where Booking_Status = "Success";
select * from Successful_Bookings;

-- Q.2 . Find the average ride distance for each vehicle type:--
create view ride_distance_for_each_vehicle_type as 
select Vehicle_Type, round(avg(Ride_Distance),2) as avg_ride_distance from bookings group by Vehicle_Type order by 
avg_ride_distance desc;
select * from ride_distance_for_each_vehicle_type;

-- Q.3 Get the total number of cancelled rides by customers:--
select count(*) from bookings where Booking_Status = "Canceled by Customer";

-- Q.4 List the top 5 customers who booked the highest number of rides:--
Create view top_5_customers_who_booked_the_highest_number_of_rides as
select Customer_ID, count(Booking_ID) as total_rides from bookings group by Customer_ID order by total_rides desc
limit 5;
select * from top_5_customers_who_booked_the_highest_number_of_rides;

-- Q.5 Get the number of rides cancelled by drivers due to personal and car-related issues:--
select count(*) from bookings where Canceled_Rides_by_Driver = "Personal & Car related issue";

-- Q.6 Find the maximum and minimum driver ratings for Prime Sedan bookings:--
select max(Driver_Ratings) as max_rating, min(Driver_Ratings) as min_rating from bookings where Vehicle_Type = 
"Prime Sedan";

-- Q.7 Retrieve all rides where payment was made using UPI:--
create view payment_method_UPI as select * from bookings where Payment_Method = "UPI";
select * from payment_method_UPI;

-- Q.8 Find the average customer rating per vehicle type:--
select Vehicle_Type, round(avg(Customer_Rating),2) as avg_customer_rating from bookings group by Vehicle_Type order by 
avg_customer_rating desc;

-- Q.9 Calculate the total booking value of rides completed successfully:--
select sum(Booking_Value) as total_successful_value from bookings where Booking_Status = "Success";

-- Q.10 List all incomplete rides along with the reason:--
select Booking_ID, Incomplete_Rides_Reason from bookings where Incomplete_Rides = "Yes";