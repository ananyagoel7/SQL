create database human_resource;
select * from hr;
alter table hr change column ï»¿id emp_id varchar(20) null;
describe hr;
select birthdate, age from hr;
update hr set birthdate = case 
when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
else null
end;
alter table hr modify column birthdate date;
update hr set hire_date = case 
when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
else null
end;

alter table hr modify column hire_date date;
UPDATE hr SET termdate = NULL WHERE termdate = '';
UPDATE hr SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%sUTC')) WHERE termdate IS NOT NULL
ALTER TABLE hr MODIFY COLUMN termdate DATE;
alter table hr add column age int;
update hr set age = timestampdiff(year, birthdate, curdate());
select min(age) as youngest, max(age) as oldest from hr;
select count(*) from hr where age < 18;
select gender, count(*) as count from hr where age >= 18 and termdate is null group by gender;
select race, count(*) as count from hr where age >= 18 and termdate is null group by race order by count desc;
select min(age) as youngest, max(age) as oldest from hr where age >= 18 and termdate is null;
select case 
when age >= 18 and age <= 24 then '18-24'
when age >= 25 and age <= 34 then '25-34'
when age >= 35 and age <= 44 then '35-44'
when age >= 45 and age <= 54 then '45-54'
when age >= 55 and age <= 64 then '55-64'
else '65+'
end as age_group, gender, count(*) as count from hr where age >= 18 and termdate is null group by age_group, gender
 order by age_group, gender;
 select location, count(*) as count from hr where age >= 18 and termdate is null group by location;
 select avg(datediff(termdate, hire_date)/365) as avg_length_emp from hr where termdate <= curdate() and termdate is not 
 null and age >= 18;
 select department, gender, count(*) as count from hr where age >= 18 and termdate is null group by department, gender
 order by department;
 select jobtitle, count(*) as count from hr where age >= 18 and termdate is null group by jobtitle order by count
 desc;
 select department, total_count, terminated_count, terminated_count/total_count as termination_rate from (select
 department, count(*) as total_count, sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end)
as terminated_count from hr where age >= 18 group by department) as subquery order by termination_rate desc;
select location_state, count(*) as count from hr where age >= 18 and termdate is null group by location_state
order by count desc;
select year, hires, terminations, hires - terminations as net_change, round((hires-terminations)/hires*100,2)
as net_change_precent from (select year(hire_date) as year, count(*) as hires, sum(case when termdate is not null
and termdate <= curdate() then 1 else 0 end) as terminations from hr where age >= 18 group by year) as subquery
order by year asc;
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure from hr where termdate <= curdate()
and termdate is not null and age >= 18 group by department;

