# Retention Pilot: Test Design

## Hypothesis
Offering at-risk customers a 15% discount to switch to a 1-year contract will reduce their churn rate by at least 10 percentage points within 3 months.

## Design
| Item | Choice |
| --- | --- |
| Population | Active customers with a risk score of 5-6 (533 customers), extended to score 4 to reach the needed sample size |
| Assignment | Random 50/50 split into control (no offer) and treatment (offer) |
| Treatment | 15% discount for 12 months if the customer moves to a 1-year contract |
| Control | Business as usual |
| Duration | Offer open for 4 weeks; churn measured 3 months after the offer |
| Primary metric | Churn rate at 3 months |
| Secondary metrics | Offer acceptance rate; revenue per customer |
| Guardrail | Net revenue per customer must not fall: the discount cannot cost more than it saves |

## Sample size (Excel Test_Design sheet)
| Input | Value |
| --- | --- |
| Baseline churn rate (high-risk) | 64.1% |
| Smallest reduction worth detecting | 10 percentage points |
| Significance level | 5% |
| Power | 80% |
| **Customers needed per group** | **379** |
| **Total needed** | **758** |
| Active high-risk customers available | 533 |

**Implication:** the high-risk group alone is too small. Including active customers with a score of 4 (649 more) gives enough customers. Alternatively, run the test longer or only aim to detect a larger effect.

## Decision rule
- **Roll out** if treatment churn is significantly lower (p < 0.05) and net revenue per customer is higher than control.
- **Stop** if churn does not fall, or if the discount cost exceeds the revenue saved.
- **Iterate** (e.g. smaller discount, auto-pay credit instead) if churn falls but the return is negative.
