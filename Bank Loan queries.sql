-- KPI's

-- Total Applications --
select count(id) as total_applications from bank_loan_data;
-- MTD Loan Application --
select count(id) as total_applications from bank_loan_data where month(issue_date) = 12;
-- PMTD Loan Application --
select count(id) as total_application from bank_loan_data where month(issue_date) = 11;

-- Total Funded Amount --
select sum(loan_amount) as total_funded_amount from bank_loan_data;
-- MTD Funded Amount --
select sum(loan_amount) as mtd_funded_amount from bank_loan_data where month(issue_date) = 12;
-- PMTD Funded Amount --
select sum(loan_amount) as pmtd_funded_amount from bank_loan_data where month(issue_date) = 11;

-- Total Amount Received --
select sum(total_payment) as total_amount_collected from bank_loan_data;
-- MTD Total Amount Received --
select sum(total_payment) as mtd_total_amount_collected from bank_loan_data where month(issue_date) = 12;
-- PMTD Total Amount Received --
select sum(total_payment) as pmtd_total_amount_collected from bank_loan_data where month(issue_date) = 11;

-- Average Interest Rate --
select avg(int_rate)*100 as avg_int_rate from bank_loan_data;
-- MTD Average Interest --
select avg(int_rate)*100 as mtd_avg_int from bank_loan_data where month(issue_date) = 12;
-- PMTD Average Interest --
select avg(int_rate)*100 as pmtd_avg_int from bank_loan_data where month(issue_date) = 11;

-- Avg DTI --
select avg(dti)*100 as avg_dti from bank_loan_data;
-- MTD Avg DTI --
select avg(dti)*100 as mtd_avg_dti from bank_loan_data where month(issue_date) = 12;
-- PMTD Avg DTI --
select avg(dti)*100 as pmtd_avg_dti from bank_loan_data where month(issue_date) = 11;

-- Good Loan issued --
-- Good Loan % 
select (count(case when loan_status = "Fully Paid" or loan_status = "Current" then id end)*100) / count(id) as 
good_loan_percentage from bank_loan_data;
-- Good Loan Applicatons --
select count(id) as good_loan_application from bank_loan_data where loan_status = "Fully Paid" or loan_status = "Current";
-- Good Loan Funded Amount --
select sum(loan_amount) as good_loan_funded_amount from bank_loan_data where loan_status = "Fully Paid" or 
loan_status = "Current";
-- Good Loan Amount Received --
select sum(total_payment) as good_loan_amt_received from bank_loan_data where loan_status = "Fully Paid" or 
loan_status = "Current";

-- Bad Loan Issued --
-- Bad Loan % --
select (count(case when loan_status = "Charged Off" then id end)*100) / count(id) as bad_loan_percentage from 
bank_loan_data;
-- Bad Loan Applicatons --
select count(id) as bad_loan_application from bank_loan_data where loan_status = "Charged Off";
-- Bad Loan Funded Amount --
select sum(loan_amount) as bad_loan_funded_amount from bank_loan_data where loan_status = "Charged Off";
-- Bad Loan Amount Received --
select sum(total_payment) as bad_loan_amt_received from bank_loan_data where loan_status = "Charged Off";

-- Loan Status --
select loan_status, count(id) as loancount, sum(total_payment) as total_amt_received, sum(loan_amount) as 
total_funded_amount, avg(int_rate * 100) as int_rate, avg(dti * 100) as dti from bank_loan_data group by loan_status;
select loan_status, sum(total_payment) as mtd_total_amt_received, sum(loan_amount) as mtd_total_funded_amount
from bank_loan_data where month(issue_date) = 12 group by loan_status;

-- Month wise bank loan report -- 
SELECT MONTH(issue_date) AS Month_Munber, DATENAME(MONTH, issue_date) AS Month_name, COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date) ORDER BY MONTH(issue_date);
