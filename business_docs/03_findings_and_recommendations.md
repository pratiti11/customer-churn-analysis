# Memo: Reducing Customer Churn

**To:** Head of Customer Retention  **From:** Pratiti Toppo, Data Analyst
**Subject:** Who is leaving, what it costs, and what to do next

## Summary
We lose about **1 in 4 customers**, costing **$139K in monthly revenue ($1.67M a year)**. Churn is concentrated, not random: **one profile, month-to-month fiber customers paying by electronic check, accounts for 49% of all lost revenue.** A simple 6-factor risk score identifies **533 active customers ($41.8K monthly revenue)** who are very likely to leave. I recommend piloting a discounted 1-year contract offer for this group, which could add about **$47K in net revenue a year** under conservative assumptions.

## Key findings
1. **Contract type is the strongest driver.** Month-to-month customers churn at 42.7%, vs 11.3% on 1-year and 2.8% on 2-year contracts. They account for 86.9% of lost revenue.
2. **The first year is the danger zone.** 47.4% of customers in their first 12 months leave, vs 9.5% after four years.
3. **Electronic-check payers churn at 45.3%**, about 3x the rate of customers on automatic bank or card payment (15-17%).
4. **Fiber optic customers churn at 41.9%** vs 19.0% for DSL, and they make up 82% of lost revenue. They pay the highest bills, so this may reflect price or service expectations.
5. **Protective add-ons are linked to loyalty.** Internet customers with no add-ons churn at 52.2%; with all six, 5.3%. Without tech support or online security, churn is about 42%, vs about 15% with them.
6. **The riskiest profile** (month-to-month + fiber + electronic check) has 1,307 customers, a 60.4% churn rate and $68.3K of lost monthly revenue.
7. **All drivers above are statistically significant** (chi-square p < 0.001), so they are not chance patterns. They show association, not proven cause.

## Recommendations
| # | Action | Owner | Why |
| --- | --- | --- | --- |
| 1 | Pilot a discounted 1-year contract offer for the 533 active high-risk customers | Retention | Contract length is the strongest driver; modelled net gain about $47K/year at 25% acceptance and 15% discount |
| 2 | Move electronic-check payers to automatic payment (e.g. small one-time credit) | Billing / Marketing | Auto-pay customers churn at about a third of the rate |
| 3 | Add a first-90-days onboarding programme for new customers | Customer Service | Nearly half of first-year customers leave |
| 4 | Bundle tech support / online security free for 3 months with new fiber plans | Product | Customers with these services churn about 2.7x less |
| 5 | Review fiber pricing and service quality | Product / Network | Fiber customers churn at twice the DSL rate despite (or because of) higher bills |

## Financial impact (Excel Retention_Scenario sheet)
| Assumption | Value |
| --- | --- |
| Target customers | 533 active high-risk customers |
| Acceptance rate | 25% |
| Discount | 15% for 12 months |
| Churn after switching | 11.3% (current 1-year customers) |
| **Net revenue gained in year 1** | **about $47,500** |
| Return per $1 of discount | about $2.50 |

The sensitivity table shows a positive return at every combination tested (10-40% acceptance, 5-25% discount), from about $14K to $96K.

## Risks and caveats
- Customers who switch may still churn more than existing 1-year customers, so the modelled gain is optimistic. **This is why a pilot comes first.**
- The 64% churn rate used for high-risk customers is historical; future churn could differ.
- The data is a single snapshot with no price-change or service-quality history.

## Next step
Approve the pilot described in `04_retention_pilot_design.md`. Because only 533 high-risk customers are available and the test needs about 760, the pilot should include medium-risk customers with a score of 4.
