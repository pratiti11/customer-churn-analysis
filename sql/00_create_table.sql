-- Run this FIRST, then import data/telco_customer_churn.csv into this table.
-- Creating the table with the right types makes number comparisons (tenure <= 12) work correctly.
-- Works in SQLite (DB Browser for SQLite), MySQL and PostgreSQL.
CREATE TABLE customers (
    customerID        VARCHAR(20) PRIMARY KEY,
    gender            VARCHAR(10),
    SeniorCitizen     INTEGER,
    Partner           VARCHAR(5),
    Dependents        VARCHAR(5),
    tenure            INTEGER,
    PhoneService      VARCHAR(5),
    MultipleLines     VARCHAR(20),
    InternetService   VARCHAR(20),
    OnlineSecurity    VARCHAR(25),
    OnlineBackup      VARCHAR(25),
    DeviceProtection  VARCHAR(25),
    TechSupport       VARCHAR(25),
    StreamingTV       VARCHAR(25),
    StreamingMovies   VARCHAR(25),
    Contract          VARCHAR(20),
    PaperlessBilling  VARCHAR(5),
    PaymentMethod     VARCHAR(30),
    MonthlyCharges    DECIMAL(10,2),
    TotalCharges      VARCHAR(20),   -- kept as text: 11 values are blank (see Q1)
    Churn             VARCHAR(5)
);
