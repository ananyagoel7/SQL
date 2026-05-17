# 🗄️ SQL Data Analysis Projects

## 📌 Project Overview

This repository showcases **SQL-based Data Analysis Projects** 
using advanced SQL queries including JOINs, aggregations, 
subqueries, window functions, and date functions — analyzing 
FDA Drug Approval data and Pizza Sales data to uncover 
meaningful business insights.

---

## 👩‍💼 About Me

- 🔭 Currently working as **Data & Delivery Lead at AIQoD**
- 📍 Based in **Delhi NCR, India**
- 💡 Passionate about turning raw data into actionable business insights
- 🎯 Open to **Data Analyst | Business Analyst | Power BI Developer** roles
- 📫 Reach me at: **ananyagoel.brac@gmail.com**
- 🔗 LinkedIn: [linkedin.com/in/ananya-goel05](https://linkedin.com/in/ananya-goel05)
- 📊 Power BI Projects: [github.com/ananyagoel7/Power-Bi](https://github.com/ananyagoel7/Power-Bi)
- 📊 Excel Projects: [github.com/ananyagoel7/Excel](https://github.com/ananyagoel7/Excel)

---

## 🛠️ Tools & Technologies Used

| Tool | Purpose |
|---|---|
| **MySQL** | Query writing and execution |
| **Power BI** | Dashboard visualization on top of SQL data |
| **Excel** | Data validation and exploration |
| **DAX** | Custom measures for Power BI reports |

---

## 📁 Projects

---

## 🍕 Project 1 — Pizza Sales Analysis

### Overview
A comprehensive SQL analysis of pizza sales data uncovering 
revenue trends, order patterns, category performance, size 
preferences, and best/worst performing pizzas — helping 
restaurant businesses make data-driven menu and marketing decisions.

---

### 📊 Key KPIs Tracked

| Metric | SQL Query Used |
|---|---|
| **Total Revenue** | SUM(total_price) |
| **Average Order Value** | SUM(total_price) / COUNT(DISTINCT order_id) |
| **Total Pizzas Sold** | SUM(quantity) |
| **Total Orders** | COUNT(DISTINCT order_id) |
| **Average Pizzas Per Order** | SUM(quantity) / COUNT(DISTINCT order_id) |

---

### 📊 Analysis Performed

#### ✅ Query 1 — Core KPIs
```sql
-- Total Revenue
SELECT SUM(total_price) AS total_revenue 
FROM pizza_sales;

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) 
AS avg_order_value FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
AS avg_pizzas_per_order FROM pizza_sales;
```
**Insight:** Establishes baseline business performance metrics for the pizza restaurant.

---

#### ✅ Query 2 — Daily Trend For Total Orders
```sql
SELECT DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) 
AS order_day,
COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY order_day;
```
**Insight:** Identifies which days of the week drive the most orders — helps with staffing and inventory planning.

---

#### ✅ Query 3 — Monthly Trends For Total Orders
```sql
SELECT MONTHNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) 
AS month_name,
COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY month_name 
ORDER BY total_orders DESC;
```
**Insight:** Reveals peak and slow months — helps with seasonal promotions and planning.

---

#### ✅ Query 4 — Percentage of Sales by Pizza Category
```sql
-- Overall Category Sales %
SELECT pizza_category, 
SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales) AS pct 
FROM pizza_sales 
GROUP BY pizza_category;

-- January Category Sales %
SELECT pizza_category, 
SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales WHERE MONTH(order_date) = 1) AS pct 
FROM pizza_sales 
WHERE MONTH(order_date) = 1 
GROUP BY pizza_category;
```
**Insight:** Shows which pizza categories — Classic, Supreme, Veggie, Chicken — contribute most to revenue.

---

#### ✅ Query 5 — Percentage of Sales by Pizza Size
```sql
SELECT pizza_size, 
SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales) AS pct 
FROM pizza_sales 
GROUP BY pizza_size 
ORDER BY pct DESC;
```
**Insight:** Identifies most popular pizza sizes — Large, Medium, Small, XL — by revenue contribution.

---

#### ✅ Query 6 — Top & Bottom 5 Sellers

```sql
-- Top 5 by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_revenue DESC LIMIT 5;

-- Bottom 5 by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_revenue ASC LIMIT 5;

-- Top 5 by Quantity
SELECT pizza_name, SUM(quantity) AS total_quantity 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_quantity DESC LIMIT 5;

-- Bottom 5 by Quantity
SELECT pizza_name, SUM(quantity) AS total_quantity 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_quantity ASC LIMIT 5;

-- Top 5 by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_order 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_order DESC LIMIT 5;

-- Bottom 5 by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_order 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_order ASC LIMIT 5;
```
**Insight:** Identifies star performers and underperforming pizzas across 3 dimensions — revenue, quantity, and orders.

---

### 💡 SQL Concepts Used

| Concept | Where Used |
|---|---|
| **SUM, COUNT** | Revenue and order aggregations |
| **DISTINCT** | Unique order counting |
| **CAST** | Decimal precision for averages |
| **DAYNAME** | Extract day name from date |
| **MONTHNAME** | Extract month name from date |
| **STR_TO_DATE** | Convert string to date format |
| **Subqueries** | Percentage calculations |
| **GROUP BY** | Category and size aggregations |
| **ORDER BY + LIMIT** | Top and bottom 5 rankings |
| **MONTH()** | Filter by specific month |

---

### 🔑 Key Business Insights

| Finding | Detail |
|---|---|
| **Peak Day** | Friday and Saturday highest orders |
| **Peak Month** | January and July highest orders |
| **Top Category** | Classic category leads revenue |
| **Top Size** | Large pizzas most popular |
| **Best Seller** | Thai Chicken Pizza highest revenue |
| **Worst Seller** | Brie Carre Pizza lowest revenue |

---

📂 [View Project File](https://github.com/ananyagoel7/SQL/blob/main/pizza_sales.sql)

---

## 💊 Project 2 — FDA Drug Approval Analysis

### Overview
A comprehensive SQL analysis of the **FDA Drug Approval dataset** 
uncovering approval trends, market segmentation, product insights, 
and therapeutic class patterns across multiple decades of drug 
approval data.

---

### 📂 Dataset Tables Used

| Table | Description |
|---|---|
| **Application** | Drug application details and sponsor information |
| **RegActionDate** | Regulatory action dates and action types |
| **Product** | Product details, dosage forms, and market status |

---

### 📊 Task 1 — Identifying Approval Trends

#### ✅ Query 1 — Yearly Drug Approvals
```sql
SELECT YEAR(rd.ActionDate) AS approval_year,
COUNT(DISTINCT a.ApplNo) AS num_drugs_approved 
FROM application a 
JOIN regactiondate rd ON a.ApplNo = rd.ApplNo 
WHERE rd.ActionType = 'AP' 
GROUP BY approval_year 
ORDER BY approval_year;
```
**Insight:** Tracks total unique drugs approved each year across the entire dataset.

---

#### ✅ Query 2 — Top 3 & Bottom 3 Approval Years
```sql
-- Highest Approvals
SELECT YEAR(a.ActionDate) AS approval_year,
COUNT(DISTINCT p.ApplNo) AS num_approvals 
FROM regactiondate a 
INNER JOIN application app ON a.ApplNo = app.ApplNo 
INNER JOIN Product p ON app.ApplNo = p.ApplNo
WHERE a.ActionType = 'AP' 
GROUP BY YEAR(a.ActionDate) 
ORDER BY num_approvals DESC LIMIT 3;

-- Lowest Approvals
SELECT YEAR(a.ActionDate) AS approval_year,
COUNT(DISTINCT p.ApplNo) AS num_approvals 
FROM regactiondate a 
INNER JOIN application app ON a.ApplNo = app.ApplNo 
INNER JOIN Product p ON app.ApplNo = p.ApplNo
WHERE a.ActionType = 'AP' 
GROUP BY YEAR(a.ActionDate) 
ORDER BY num_approvals ASC LIMIT 3;
```
**Insight:** Identifies peak and low approval years to understand regulatory activity patterns.

---

#### ✅ Query 3 — Approvals by Sponsor Applicant
```sql
SELECT YEAR(ra.ActionDate) AS approval_year, 
a.SponsorApplicant,
COUNT(*) AS num_approvals 
FROM application a 
JOIN regactiondate ra ON a.ApplNo = ra.ApplNo 
WHERE a.ActionType = 'AP' 
AND ra.ActionDate IS NOT NULL 
GROUP BY YEAR(ra.ActionDate), a.SponsorApplicant 
ORDER BY approval_year, num_approvals DESC;
```
**Insight:** Reveals which pharmaceutical companies received most approvals each year.

---

#### ✅ Query 4 — Historical Approvals (1939-1960)
```sql
SELECT YEAR(rd.ActionDate) AS approval_year, 
a.SponsorApplicant,
COUNT(DISTINCT a.ApplNo) AS num_approvals 
FROM application a 
JOIN regactiondate rd ON a.ApplNo = rd.ApplNo 
WHERE YEAR(rd.ActionDate) BETWEEN 1939 AND 1960 
GROUP BY YEAR(rd.ActionDate), a.SponsorApplicant
ORDER BY YEAR(rd.ActionDate), num_approvals DESC;
```
**Insight:** Explores early FDA drug approval history and dominant sponsors of that era.

---

### 📊 Task 2 — Segmentation Analysis

#### ✅ Query 1 — Product Count by Marketing Status
```sql
SELECT ProductMktStatus, COUNT(*) AS num_products,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM product), 2) 
AS percentage 
FROM product 
GROUP BY ProductMktStatus;
```
**Insight:** Shows percentage of drugs actively marketed vs discontinued vs withdrawn.

---

#### ✅ Query 2 — Post 2010 Approvals by Marketing Status
```sql
SELECT YEAR(R.ActionDate) AS ApprovalYear, 
P.ProductMktStatus, 
COUNT(DISTINCT A.ApplNo) AS TotalApplications
FROM regactiondate R 
JOIN application A ON R.ApplNo = A.ApplNo
JOIN product P ON A.ApplNo = P.ApplNo
WHERE YEAR(R.ActionDate) > 2010
GROUP BY ApprovalYear, P.ProductMktStatus 
ORDER BY ApprovalYear, P.ProductMktStatus;
```
**Insight:** Tracks modern drug approval patterns segmented by current market status.

---

### 📊 Task 3 — Analyzing Products

#### ✅ Query 1 — Products by Dosage Form
```sql
SELECT Form AS Dosage_Form, 
COUNT(*) AS Num_Products 
FROM Product 
GROUP BY Form 
ORDER BY Num_Products DESC;
```
**Insight:** Identifies most common drug delivery forms — tablets, capsules, injections.

---

#### ✅ Query 2 — Successful Dosage Forms by Year
```sql
SELECT YEAR(ActionDate) AS approval_year, 
p.Form,
COUNT(*) AS num_successful_forms 
FROM Product p 
INNER JOIN RegActionDate rad ON p.ApplNo = rad.ApplNo 
WHERE p.ProductMktStatus = 1 
GROUP BY YEAR(ActionDate), p.Form 
ORDER BY approval_year, num_successful_forms DESC;
```
**Insight:** Shows which dosage forms have been most successful in receiving approvals over time.

---

### 📊 Task 4 — Therapeutic Classes

#### ✅ Query 1 — Total Approvals by Therapeutic Class
```sql
SELECT P.TECode, 
COUNT(DISTINCT A.ApplNo) AS TotalApprovals 
FROM Product P 
JOIN Application A ON P.ApplNo = A.ApplNo 
WHERE A.ActionType = 'AP' 
AND P.TECode IS NOT NULL 
GROUP BY P.TECode 
ORDER BY TotalApprovals DESC;
```
**Insight:** Identifies which therapeutic classes received most FDA approvals overall.

---

#### ✅ Query 2 — Top Therapeutic Class Per Year
```sql
SELECT ApprovalYear, TE_Code, TotalApprovals 
FROM (
    SELECT YEAR(R.ActionDate) AS ApprovalYear, 
    P.TECode AS TE_Code, 
    COUNT(DISTINCT A.ApplNo) AS TotalApprovals, 
    ROW_NUMBER() OVER (
        PARTITION BY YEAR(R.ActionDate) 
        ORDER BY COUNT(DISTINCT A.ApplNo) DESC
    ) AS RN 
    FROM Product P 
    JOIN Application A ON P.ApplNo = A.ApplNo 
    JOIN RegActionDate R ON R.ApplNo = A.ApplNo 
    WHERE A.ActionType = 'AP' 
    AND P.TECode IS NOT NULL 
    GROUP BY ApprovalYear, TE_Code
) AS Ranked 
WHERE RN = 1;
```
**Insight:** Uses window functions to identify leading therapeutic class for every year.

---

### 💡 SQL Concepts Used — FDA Project

| Concept | Where Used |
|---|---|
| **INNER JOIN** | Combining multiple tables |
| **LEFT JOIN** | Including all products |
| **GROUP BY** | Aggregating by year, sponsor, form |
| **COUNT DISTINCT** | Unique drug application counts |
| **WHERE filters** | Action type, date ranges, market status |
| **ROUND** | Percentage calculations |
| **ROW_NUMBER()** | Window function for ranking |
| **PARTITION BY** | Yearly partitioning |
| **Subqueries** | Percentage and ranked results |
| **BETWEEN** | Historical date range filtering |

📂 [View Project File](https://github.com/ananyagoel7/SQL/blob/main/FDA%20sql.sql)

---

## 💡 What These Projects Demonstrate

| Skill | How Demonstrated |
|---|---|
| **SQL Proficiency** | JOINs, subqueries, window functions, date functions |
| **Data Analysis** | Patterns across sales and regulatory datasets |
| **Business Thinking** | Insights tied to real business decisions |
| **Problem Solving** | Multi-table analysis and complex aggregations |
| **Data Storytelling** | Numbers translated into clear insights |
| **Domain Knowledge** | Food & Beverage, Pharmaceutical analytics |

---

## 📊 Projects Summary

| Project | Domain | Key Analysis | Tools |
|---|---|---|---|
| **Pizza Sales** | Food & Beverage | Revenue, Orders, Top/Bottom Sellers | MySQL, Power BI |
| **FDA Drug Approval** | Pharmaceutical | Approval Trends, Therapeutic Classes | MySQL, Power BI |

---

## 🤝 Let's Connect

- 📧 Email: ananyagoel.brac@gmail.com
- 💼 LinkedIn: [linkedin.com/in/ananya-goel05](https://linkedin.com/in/ananya-goel05)
- 📊 Power BI Projects: [github.com/ananyagoel7/Power-Bi](https://github.com/ananyagoel7/Power-Bi)
- 📊 Excel Projects: [github.com/ananyagoel7/Excel](https://github.com/ananyagoel7/Excel)
- 💻 GitHub: [github.com/ananyagoel7](https://github.com/ananyagoel7)

---

⭐ **If you found these projects useful — please star this repository!**
