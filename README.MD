# 💊 FDA Drug Approval Analysis | SQL & Power BI

## 📌 Project Overview

This project analyzes the **FDA Drug Approval dataset** using advanced SQL queries and Power BI visualizations to uncover approval trends, market segmentation, product insights, and therapeutic class patterns across multiple decades of drug approval data.

---

## 👩‍💼 About Me

- 🔭 Currently working as **Data & Delivery Lead at AIQoD**
- 📍 Based in **Delhi NCR, India**
- 💡 Passionate about turning raw data into actionable business insights
- 🎯 Open to **Data Analyst | Business Analyst | Power BI Developer** roles
- 📫 Reach me at: **ananyagoel.brac@gmail.com**
- 🔗 LinkedIn: [linkedin.com/in/ananya-goel05](https://linkedin.com/in/ananya-goel05)
- 📊 Power BI Projects: [github.com/ananyagoel7/Power-Bi](https://github.com/ananyagoel7/Power-Bi)

---

## 🛠️ Tools & Technologies Used

| Tool | Purpose |
|---|---|
| **SQL** | Data extraction, joins, aggregations, subqueries |
| **Power BI** | Dashboard design and visualization |
| **DAX** | Custom measures and calculations |
| **Power Query** | Data transformation and cleaning |
| **Excel** | Data validation and exploration |

---

## 📂 Dataset Tables Used

| Table | Description |
|---|---|
| **Application** | Drug application details and sponsor information |
| **RegActionDate** | Regulatory action dates and action types |
| **Product** | Product details, dosage forms, and market status |

---

## 📊 Project Tasks & SQL Queries

---

### 📌 Task 1 — Identifying Approval Trends

**Objective:** Analyze yearly drug approval trends to identify patterns over time.

---

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
**Insight:** Tracks total number of unique drugs approved each year across the entire dataset.

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
**Insight:** Reveals which pharmaceutical companies received the most approvals each year.

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

### 📌 Task 2 — Segmentation Analysis Based on Drug Marketing Status

**Objective:** Understand distribution of drugs across different marketing statuses.

---

#### ✅ Query 1 — Product Count by Marketing Status
```sql
SELECT ProductMktStatus, COUNT(*) AS num_products
FROM Product 
GROUP BY ProductMktStatus;

-- With Percentage
SELECT ProductMktStatus, COUNT(*) AS num_products,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM product), 2) AS percentage 
FROM product 
GROUP BY ProductMktStatus;
```
**Insight:** Shows what percentage of drugs are actively marketed vs discontinued vs withdrawn.

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

#### ✅ Query 3 — Top 5 Application Years by Marketing Status
```sql
SELECT ProductMktStatus, 
YEAR(ActionDate) AS application_year, 
COUNT(*) AS num_applications
FROM regactiondate
LEFT JOIN product ON regactiondate.ApplNo = product.ApplNo
GROUP BY 1, 2 
ORDER BY 3 DESC LIMIT 5;
```
**Insight:** Identifies which years had highest application volumes by marketing status.

---

### 📌 Task 3 — Analyzing Products

**Objective:** Analyze drug products by dosage form to identify most common and successful forms.

---

#### ✅ Query 1 & 2 — Products by Dosage Form
```sql
SELECT Form AS Dosage_Form, 
COUNT(*) AS Num_Products 
FROM Product 
GROUP BY Form 
ORDER BY Num_Products DESC;
```
**Insight:** Identifies the most common drug delivery forms — tablets, capsules, injections etc.

---

#### ✅ Query 3 — Successful Dosage Forms by Year
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

### 📌 Task 4 — Exploring Therapeutic Classes and Approval Trends

**Objective:** Analyze drug approvals by therapeutic equivalence codes to identify dominant therapeutic classes.

---

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
**Insight:** Identifies which therapeutic classes have received the most FDA approvals overall.

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
**Insight:** Uses **window functions** to identify the leading therapeutic class for every single year — showing how dominant drug categories shifted over time.

---

## 📈 Power BI Dashboard

Built an interactive Power BI dashboard on top of this SQL analysis tracking:

- ✅ Year-over-year drug approval trends
- ✅ Marketing status distribution
- ✅ Top dosage forms by approval count
- ✅ Therapeutic class dominance over time
- ✅ Interactive filters for year, sponsor, and drug category

---

## 🔑 Key Insights From Analysis

| Finding | Detail |
|---|---|
| **Peak Approval Years** | Identified top 3 years with highest FDA approvals |
| **Dominant Sponsors** | Revealed top pharmaceutical companies by approval count |
| **Most Common Form** | Tablets and capsules dominate drug delivery forms |
| **Post 2010 Trends** | Shift in marketing status distribution of modern drugs |
| **Top Therapeutic Class** | Identified leading TE code by approvals each year |
| **Historical Patterns** | Analyzed early FDA approvals from 1939-1960 |

---

## 💡 SQL Concepts Used

| Concept | Where Used |
|---|---|
| **INNER JOIN** | Combining application, product, and action date tables |
| **LEFT JOIN** | Including all products regardless of action date |
| **GROUP BY** | Aggregating by year, sponsor, dosage form |
| **COUNT DISTINCT** | Unique drug application counts |
| **WHERE filters** | Action type, date ranges, market status |
| **ORDER BY** | Sorting by approvals ascending and descending |
| **LIMIT** | Top 3 and bottom 3 results |
| **ROUND** | Percentage calculations |
| **ROW_NUMBER()** | Window function for ranking by year |
| **PARTITION BY** | Yearly partitioning for therapeutic class ranking |
| **Subqueries** | Percentage calculation and ranked results |

---

## 🤝 Let's Connect

- 📧 Email: ananyagoel.brac@gmail.com
- 💼 LinkedIn: [linkedin.com/in/ananya-goel05](https://linkedin.com/in/ananya-goel05)
- 📊 Power BI Projects: [github.com/ananyagoel7/Power-Bi](https://github.com/ananyagoel7/Power-Bi)
- 💻 GitHub: [github.com/ananyagoel7](https://github.com/ananyagoel7)

---

⭐ **If you found this project useful — please star this repository!**
