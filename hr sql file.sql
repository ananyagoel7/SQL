select * from hrdata;
select sum(employee_count) from hrdata where education = 'High School';
select sum(employee_count) from hrdata where department = 'Sales';
select sum(employee_count) from hrdata where department = 'R&D';
select sum(employee_count) from hrdata where education_field = 'Medical';
select count(attrition) from hrdata where attrition = 'Yes';
select count(attrition) from hrdata where attrition = 'Yes' and
education = 'Doctoral Degree';
select count(attrition) from hrdata where attrition = 'Yes' and
department = 'R&D';
select count(attrition) from hrdata where attrition = 'Yes' and
education_field  = 'Medical' and department = 'R&D';
Select count(attrition) from hrdata where attrition = 'Yes' and
education_field  = 'Medical' and department = 'R&D' and 
education = 'High School';
select round(((select count(attrition) from hrdata where attrition = 'Yes')/
sum(employee_count))*100,2) as attrition_rate from hrdata;
select round(((select count(attrition) from hrdata where
 attrition = 'Yes' and department = 'Sales')/
sum(employee_count))*100,2) as attrition_rate from hrdata where department 
= 'Sales';
select round(((select count(attrition) from hrdata where attrition = 
'Yes' and department = 'Sales' and education_field = 'Marketing')/
sum(employee_count))*100,2) as attrition_rate from hrdata where department 
= 'Sales' and education_field = 'Marketing';
select sum(employee_count) - (select count(attrition) from hrdata 
 where attrition = 'Yes' ) as active_employees from hrdata;
 select sum(employee_count) - (select count(attrition) from hrdata
 where attrition = 'Yes' and gender = 'Male') as active_employees
 from hrdata where gender = 'Male';
 select sum(employee_count) - (select count(attrition) from 
 hrdata  where attrition = 'Yes' and gender = 'Female' and department 
 = 'HR' and education_field = 'Life Sciences'  ) as 
 active_employees from hrdata where gender = 'Female' and department 
 = 'HR' and education_field = 'Life Sciences';
 select round(avg(age),0) as avg_age from hrdata;
 -----attrition by gender-----
 select gender , count(attrition) from hrdata where attrition = 'Yes'
and education = 'High School' group by gender order by 
count(attrition) desc;
select gender , count(attrition) from hrdata where attrition = 'Yes'
and education = 'High School' and department = 'Sales' group by gender order by 
count(attrition) desc;
------department wise attrition-----
select department, count(attrition) from hrdata where attrition = 'Yes'
group by department order by count(attrition) desc;
-----age-----
select age, sum(employee_count) from hrdata group by age order by age;
select age, sum(employee_count) from hrdata where department = 'R&D'
group by age order by age;
-------education field wise attrition-----
select education_field, count(attrition) from hrdata where attrition =
 'Yes' group by education_field order by count(attrition) desc;
 select education_field, count(attrition) from hrdata where attrition =
 'Yes' and department = 'Sales' group by education_field 
 order by count(attrition) desc;
 -----attrition by rate----
 select age_band, gender, count(attrition) from hrdata where 
 attrition = 'Yes' group by age_band , gender order by age_band , 
 gender;
 
 
 
 

