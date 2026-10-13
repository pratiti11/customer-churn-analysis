-- =====================================================================
-- Customer Churn Analysis: SQL queries
-- Table: customers  (run 00_create_table.sql, then import data/telco_customer_churn.csv)
-- Written in standard SQL. Tested in SQLite (DB Browser for SQLite) and DuckDB.
-- Also runs in MySQL 8+ and PostgreSQL (window functions required).
-- =====================================================================


-- Q1. Data quality: row count, duplicate IDs, and blank TotalCharges
SELECT COUNT(*)                                                    AS customers,
       COUNT(DISTINCT customerID)                                  AS unique_ids,
       SUM(CASE WHEN TRIM(TotalCharges) = '' THEN 1 ELSE 0 END)    AS blank_total_charges,
       MIN(tenure)                                                 AS min_tenure,
       MAX(tenure)                                                 AS max_tenure
FROM customers;


-- Q2. Headline KPIs: churn rate and monthly revenue lost
SELECT COUNT(*)                                                         AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)                   AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct,
       ROUND(SUM(MonthlyCharges), 0)                                    AS monthly_revenue,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0)       AS lost_monthly_revenue,
       ROUND(12 * SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0)  AS annual_revenue_lost
FROM customers;


-- Q3. Churn by contract type, with share of lost revenue (window function)
SELECT Contract,
       COUNT(*)                                                         AS customers,
       ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END), 1) AS churn_rate_pct,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS lost_mrr,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END)
             / SUM(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END)) OVER (), 1) AS pct_of_lost_mrr
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;


-- Q4. Churn by tenure band (CASE WHEN to create groups)
WITH banded AS (
    SELECT *,
           CASE WHEN tenure <= 12 THEN '1. 0-12 months'
                WHEN tenure <= 24 THEN '2. 13-24 months'
                WHEN tenure <= 48 THEN '3. 25-48 months'
                ELSE                   '4. 49-72 months' END AS tenure_band
    FROM customers
)
SELECT tenure_band,
       COUNT(*)                                                           AS customers,
       ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END), 1) AS churn_rate_pct
FROM banded
GROUP BY tenure_band
ORDER BY tenure_band;


-- Q5. Payment method: churn rate and lift vs the overall average
WITH by_method AS (
    SELECT PaymentMethod,
           COUNT(*)                                           AS customers,
           SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)     AS churned
    FROM customers
    GROUP BY PaymentMethod
)
SELECT PaymentMethod,
       customers,
       ROUND(100.0 * churned / customers, 1)                                         AS churn_rate_pct,
       ROUND((1.0 * churned / customers) / (1.0 * SUM(churned) OVER () / SUM(customers) OVER ()), 2) AS lift
FROM by_method
ORDER BY lift DESC;


-- Q6. Protective services: churn with and without tech support / online security
SELECT 'Tech support' AS service, TechSupport AS has_service,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END), 1) AS churn_rate_pct
FROM customers
WHERE InternetService <> 'No'
GROUP BY TechSupport
UNION ALL
SELECT 'Online security', OnlineSecurity,
       COUNT(*),
       ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END), 1)
FROM customers
WHERE InternetService <> 'No'
GROUP BY OnlineSecurity
ORDER BY service, has_service;


-- Q7. Number of add-on services vs churn (internet customers only)
WITH addons AS (
    SELECT Churn,
           (CASE WHEN OnlineSecurity   = 'Yes' THEN 1 ELSE 0 END
          + CASE WHEN OnlineBackup     = 'Yes' THEN 1 ELSE 0 END
          + CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END
          + CASE WHEN TechSupport      = 'Yes' THEN 1 ELSE 0 END
          + CASE WHEN StreamingTV      = 'Yes' THEN 1 ELSE 0 END
          + CASE WHEN StreamingMovies  = 'Yes' THEN 1 ELSE 0 END) AS addon_count
    FROM customers
    WHERE InternetService <> 'No'
)
SELECT addon_count,
       COUNT(*)                                                           AS customers,
       ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END), 1) AS churn_rate_pct
FROM addons
GROUP BY addon_count
ORDER BY addon_count;


-- Q8. Riskiest profiles: contract x internet x payment (100+ customers), ranked
WITH profiles AS (
    SELECT Contract, InternetService, PaymentMethod,
           COUNT(*)                                                 AS customers,
           AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END)         AS churn_rate,
           SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS lost_mrr
    FROM customers
    GROUP BY Contract, InternetService, PaymentMethod
    HAVING COUNT(*) >= 100
)
SELECT RANK() OVER (ORDER BY churn_rate DESC) AS risk_rank,
       Contract, InternetService, PaymentMethod, customers,
       ROUND(100.0 * churn_rate, 1)          AS churn_rate_pct,
       ROUND(lost_mrr, 0)                    AS lost_mrr
FROM profiles
ORDER BY risk_rank
LIMIT 5;


-- Q9. Risk score (0-6): does a higher score really mean more churn?
WITH scored AS (
    SELECT *,
           (CASE WHEN Contract = 'Month-to-month'     THEN 1 ELSE 0 END
          + CASE WHEN InternetService = 'Fiber optic' THEN 1 ELSE 0 END
          + CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END
          + CASE WHEN tenure <= 12                    THEN 1 ELSE 0 END
          + CASE WHEN TechSupport = 'No'              THEN 1 ELSE 0 END
          + CASE WHEN OnlineSecurity = 'No'           THEN 1 ELSE 0 END) AS risk_score
    FROM customers
)
SELECT risk_score,
       COUNT(*)                                                           AS customers,
       ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END), 1) AS churn_rate_pct,
       SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END)                      AS active_customers
FROM scored
GROUP BY risk_score
ORDER BY risk_score;


-- Q10. Retention call list: active high-risk customers (score 5-6), highest bills first
WITH scored AS (
    SELECT customerID, Contract, InternetService, PaymentMethod, tenure, MonthlyCharges, Churn,
           (CASE WHEN Contract = 'Month-to-month'     THEN 1 ELSE 0 END
          + CASE WHEN InternetService = 'Fiber optic' THEN 1 ELSE 0 END
          + CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END
          + CASE WHEN tenure <= 12                    THEN 1 ELSE 0 END
          + CASE WHEN TechSupport = 'No'              THEN 1 ELSE 0 END
          + CASE WHEN OnlineSecurity = 'No'           THEN 1 ELSE 0 END) AS risk_score
    FROM customers
)
SELECT customerID, risk_score, Contract, InternetService, PaymentMethod, tenure, MonthlyCharges,
       ROW_NUMBER() OVER (ORDER BY MonthlyCharges DESC) AS call_priority
FROM scored
WHERE Churn = 'No' AND risk_score >= 5
ORDER BY call_priority
LIMIT 20;


-- Q11. Size of the retention target (all active high-risk customers)
WITH scored AS (
    SELECT MonthlyCharges, Churn,
           (CASE WHEN Contract = 'Month-to-month'     THEN 1 ELSE 0 END
          + CASE WHEN InternetService = 'Fiber optic' THEN 1 ELSE 0 END
          + CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END
          + CASE WHEN tenure <= 12                    THEN 1 ELSE 0 END
          + CASE WHEN TechSupport = 'No'              THEN 1 ELSE 0 END
          + CASE WHEN OnlineSecurity = 'No'           THEN 1 ELSE 0 END) AS risk_score
    FROM customers
)
SELECT COUNT(*)                     AS active_high_risk_customers,
       ROUND(SUM(MonthlyCharges), 0) AS monthly_revenue_at_stake,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_bill
FROM scored
WHERE Churn = 'No' AND risk_score >= 5;
