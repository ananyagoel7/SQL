CREATE TABLE user_submissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    question_id INT,
    points INT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(50)
);
select * from user_submissions;
---- analysis----
-- Q.1 List all distinct users and their stats (return user_name, total_submissions, points earned)----
select username, count(id) as total_submissions, sum(points) as points_earned from user_submissions
group by username order by total_submissions desc;

-- -- Q.2 Calculate the daily average points for each user.-----
select date_format(submitted_at, '%d-%m') as day, username, round(avg(points),2) as daily_avg_points from 
user_submissions group by day, username order by username;

-- Q.3 Find the top 3 users with the most correct submissions for each day.----
with daily_submissions as (
select date_format(submitted_at, '%d-%m') as daily, username, sum(case when points > 0 then 1 else 0 
end) as correct_submissions from user_submissions group by daily, username),
users_rank as (
select daily, username, correct_submissions, dense_rank() over(partition by daily order by correct_submissions desc)
as ranking from daily_submissions)
select daily, username, correct_submissions from users_rank where ranking <=3;

-- Q.4 Find the top 5 users with the highest number of incorrect submissions.----
 select username, sum(case when points  < 0 then 1 else 0 end) as incorrect_submissions, sum(case when points > 0
then 1 else 0 end) as correct_submissions, sum(points) as points_earned from user_submissions group by username 
order by incorrect_submissions desc limit 5;

select username, sum(case when points < 0 then points else 0 end) as incorrect_sub_points_earned, sum(case when
points > 0 then points else 0 end) as correct_sub_points_earned, sum(points) as points_earned from user_submissions
 group by username order by incorrect_sub_points_earned, correct_sub_points_earned limit 5;

-- Q.5 Find the top 10 performers for each week-----
select * from ( select extract(week from submitted_at) as week_no, username, sum(points) as total_points_earned,
dense_rank() over(partition by extract(week from submitted_at) order by sum(points) desc) as ranking
from user_submissions group by username, week_no) as ct1 where ranking <= 10;

-- Q.6 Top 5 Questions by Points Earned-----
select question_id, sum(points) as total_points from user_submissions group by question_id order by total_points desc
limit 5;

-- Q.7 Users with Negative Points----
select username, sum(points) as total_points from user_submissions group by username having total_points < 0;

-- Q.8 Most Active Users by Submissions---
select username, count(*) as submission_count from user_submissions group by username order by submission_count desc
limit 5;

-- Q.9 Identify Inactive Users (No Submissions or Zero Points)----
select username from user_submissions group by username having sum(points) = 0 or count(*) = 0;

-- Q.10  Find Questions with No Points Awarded---
select question_id from user_submissions group by question_id having sum(points) = 0;

-- Q.11 User Performance by Day of the Week---
select dayname(submitted_at) as day_of_week, username, sum(points) as total_points from user_submissions group by 
day_of_week, username order by day_of_week, total_points desc;

