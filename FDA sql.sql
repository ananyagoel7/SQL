---Task 1( Identifying Approval Trends)
----ques1----
SELECT YEAR(rd.ActionDate) AS approval_year,COUNT(DISTINCT a.ApplNo) 
AS num_drugs_approved FROM application a JOIN regactiondate rd ON 
a.ApplNo = rd.ApplNo WHERE rd.ActionType = 'AP' GROUP BY 
approval_year ORDER BY approval_year;
----ques2----(highest number of approvals)
SELECT YEAR(a.ActionDate) AS approval_year,COUNT(DISTINCT p.ApplNo) 
AS num_approvals FROM regactiondate a INNER JOIN application app ON
 a.ApplNo = app.ApplNo INNER JOIN Product p ON app.ApplNo = p.ApplNo
WHERE a.ActionType = 'AP' GROUP BY YEAR(a.ActionDate) ORDER BY 
num_approvals DESC LIMIT 3;
----(lowest number of approvals)---
SELECT YEAR(a.ActionDate) AS approval_year, COUNT(DISTINCT p.ApplNo) 
AS num_approvals FROM regactiondate a INNER JOIN application app 
ON a.ApplNo = app.ApplNo INNER JOIN Product p ON app.ApplNo = p.ApplNo
WHERE a.ActionType = 'AP'GROUP BY YEAR(a.ActionDate)
ORDER BY num_approvals ASC LIMIT 3;
----ques3----
SELECT YEAR(ra.ActionDate) AS approval_year, a.SponsorApplicant,
COUNT(*) AS num_approvals FROM application a JOIN regactiondate ra 
ON a.ApplNo = ra.ApplNo where a.ActionType='AP'and ra.ActionDate
 IS NOT NULL GROUP BY YEAR(ra.ActionDate), 
a.SponsorApplicant ORDER BY approval_year, num_approvals DESC;
----ques4----
SELECT YEAR(rd.ActionDate) AS approval_year, a.SponsorApplicant,
COUNT(DISTINCT a.ApplNo) AS num_approvals FROM application a JOIN 
regactiondate rd ON a.ApplNo = rd.ApplNo WHERE YEAR(rd.ActionDate) 
BETWEEN 1939 AND 1960 GROUP BY YEAR(rd.ActionDate), a.SponsorApplicant
ORDER BY YEAR(rd.ActionDate), num_approvals DESC;

-----Task2( Segmentation Analysis Based on Drug MarketingStatus)
----ques1----
SELECT ProductMktStatus, COUNT(*) AS num_products
FROM Product GROUP BY ProductMktStatus;
SELECT ProductMktStatus, COUNT(*) AS num_products,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM product), 2) AS 
percentage FROM product GROUP BY ProductMktStatus;
-----ques2---
SELECT YEAR(R.ActionDate) AS ApprovalYear, P.ProductMktStatus, COUNT(DISTINCT A.ApplNo) AS TotalApplications
FROM regactiondate R 
JOIN application A ON R.ApplNo = A.ApplNo
JOIN product P ON A.ApplNo = P.ApplNo
WHERE YEAR(R.ActionDate) > 2010
GROUP BY ApprovalYear, P.ProductMktStatus ORDER BY ApprovalYear, P.ProductMktStatus;
-----ques3----
SELECT ProductMktStatus, YEAR(ActionDate) AS application_year, COUNT(*) AS num_applications
FROM regactiondate
LEFT JOIN product ON regactiondate.ApplNo = product.ApplNo
GROUP BY 1,2 
ORDER BY 3 DESC LIMIT 5;

-----Task3( Analyzing Products)
-----ques1----
SELECT Form AS Dosage_Form, COUNT(*) AS Num_Products FROM 
Product GROUP BY Form ORDER BY Num_Products DESC;
-----ques2----
SELECT Form, COUNT(*) AS num_approvals
FROM Product GROUP BY Form ORDER BY num_approvals DESC;
------ques3---
SELECT YEAR(ActionDate) AS approval_year, p.Form,COUNT(*) AS 
num_successful_forms FROM Product p INNER JOIN RegActionDate rad 
ON p.ApplNo = rad.ApplNo WHERE p.ProductMktStatus = 1 GROUP BY YEAR
(ActionDate), p.Form ORDER BY approval_year, num_successful_forms DESC;

----Task4(Exploring Therapeutic Classes and Approval Trends)
-----ques1----
SELECT P.TECode, COUNT(DISTINCT A.ApplNo) AS TotalApprovals 
FROM Product P JOIN Application A ON P.ApplNo = A.ApplNo 
WHERE A.ActionType = 'AP' AND P.TECode IS NOT NULL 
GROUP BY P.TECode ORDER BY TotalApprovals DESC;
------ques2----
SELECT ApprovalYear, TE_Code, TotalApprovals 
FROM (SELECT YEAR(R.ActionDate) AS ApprovalYear, P.TECode AS TE_Code, 
COUNT(DISTINCT A.ApplNo) AS TotalApprovals, ROW_NUMBER()
OVER (PARTITION BY YEAR(R.ActionDate) 
ORDER BY COUNT(DISTINCT A.ApplNo) DESC) AS RN 
FROM Product P JOIN Application A ON P.ApplNo = A.ApplNo 
JOIN RegActionDate R ON R.ApplNo = A.ApplNo 
WHERE A.ActionType = 'AP' AND P.TECode IS NOT NULL GROUP BY ApprovalYear, TE_Code) AS Ranked WHERE RN = 1;


