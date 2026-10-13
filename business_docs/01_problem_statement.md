# Problem Statement and Scope

## Background
A subscription telecom company offers phone and internet plans on month-to-month, 1-year and 2-year contracts. In the latest period, **1,869 of 7,043 customers (26.5%) left**. The customers who left were paying **$139,131 a month**, which is 30.5% of all monthly recurring revenue.

## Business problem
Leadership knows churn is high but not *who* is leaving, *why*, or *where to spend* retention budget. Retention offers are currently untargeted.

## Stakeholders
| Stakeholder | What they need from this analysis |
| --- | --- |
| Head of Customer Retention (sponsor) | Which customers to target and what offer to make |
| Finance | Revenue at risk and the return on any retention spend |
| Marketing | Segments and messages for campaigns |
| Customer Service | A prioritised list of customers to contact |
| Product / Pricing | Whether contract terms, payment options or add-ons affect churn |

## Questions to answer
1. What is the churn rate and how much revenue does it cost?
2. Which customer characteristics are most associated with churn?
3. Which customer profiles are riskiest, and how many active customers fit them?
4. What retention action is worth testing, and what return could it bring?
5. How should the action be tested before a full rollout?

## Scope
- **In scope:** 7,043 customers; contract, tenure, services, billing, payment and charges; churn in the latest period.
- **Out of scope:** call-centre logs, network quality, competitor pricing, customer satisfaction scores (not available in the data).

## Success measures for the analysis
- Identify the top 3-5 churn drivers with statistical evidence.
- Size the revenue at risk in dollars.
- Deliver a targeted, testable recommendation with an estimated return.
- Give non-technical stakeholders a dashboard they can filter themselves.

## Deliverables
| Deliverable | Location |
| --- | --- |
| Interactive Excel dashboard and analysis | `excel/Customer_Churn_Analysis.xlsx` |
| SQL analysis (11 queries) | `sql/01_churn_analysis.sql` |
| KPI definitions | `business_docs/02_kpi_definitions.md` |
| Findings and recommendations memo | `business_docs/03_findings_and_recommendations.md` |
| Pilot test design | `business_docs/04_retention_pilot_design.md` |
