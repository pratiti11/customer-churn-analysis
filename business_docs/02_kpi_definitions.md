# KPI Definitions

Every metric in the dashboard, SQL and memo follows these definitions, so all stakeholders read the numbers the same way.

| KPI | Definition | Formula | Value (all customers) |
| --- | --- | --- | --- |
| Customers | Number of customer accounts in the snapshot | COUNT(customerID) | 7,043 |
| Churned customers | Customers who left within the last month | COUNT where Churn = "Yes" | 1,869 |
| Churn rate | Share of customers who left | Churned / Customers | 26.5% |
| Monthly recurring revenue (MRR) | Total monthly bill of all customers | SUM(MonthlyCharges) | $456,117 |
| Lost MRR | Monthly bill of customers who churned | SUM(MonthlyCharges) where Churn = "Yes" | $139,131 |
| Annual revenue lost | Lost MRR over 12 months | Lost MRR x 12 | $1,669,570 |
| % of lost MRR | A segment's share of all lost revenue | Segment lost MRR / total lost MRR | e.g. month-to-month 86.9% |
| Lift | How much riskier a segment is than average | Segment churn rate / overall churn rate | e.g. electronic check 1.71x |
| Tenure | Months the customer has been with the company | tenure column | 0-72 |
| Add-on count | Optional services held (security, backup, device protection, tech support, TV, movies) | Count of "Yes" across 6 columns | 0-6 |
| Risk score | Simple rule-based churn risk | 1 point each: month-to-month, fiber optic, electronic check, tenure <= 12 months, no tech support, no online security | 0-6 |
| Risk level | Grouping of the risk score | High = 5-6, Medium = 3-4, Low = 0-2 | High: 1,485 customers |
| Retention target | Active customers with a high risk level | Risk level = High and Churn = "No" | 533 customers, $41,840 MRR |

## Data notes
- **Churn window:** "Churn = Yes" means the customer left within the last month of the snapshot.
- **TotalCharges:** blank for 11 customers with tenure 0 (not yet billed); treated as 0.
- **SeniorCitizen:** stored as 0/1 in the source; shown as No/Yes in the analysis.
- **Currency:** US dollars (fictional IBM sample data).
