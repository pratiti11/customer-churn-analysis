# Data

**Source:** [IBM Telco Customer Churn sample dataset](https://github.com/IBM/telco-customer-churn-on-icp4d), published by IBM under the Apache 2.0 license. Fictional customers; amounts in US dollars.

**File:** `telco_customer_churn.csv`, 7,043 rows (one per customer), 21 columns.

| Column | Description |
| --- | --- |
| customerID | Unique customer ID |
| gender | Male / Female |
| SeniorCitizen | 1 if 65 or older, else 0 |
| Partner, Dependents | Yes / No |
| tenure | Months with the company (0-72) |
| PhoneService, MultipleLines | Phone services |
| InternetService | DSL / Fiber optic / No |
| OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies | Add-on services: Yes / No / No internet service |
| Contract | Month-to-month / One year / Two year |
| PaperlessBilling | Yes / No |
| PaymentMethod | Electronic check / Mailed check / Bank transfer (automatic) / Credit card (automatic) |
| MonthlyCharges | Current monthly bill (USD) |
| TotalCharges | Total billed to date (USD); blank for 11 customers with tenure 0 |
| Churn | Yes if the customer left within the last month |
