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
