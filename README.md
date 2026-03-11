# 🏦 Bank Loan & Transaction Performance Analysis

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql) ![SQL](https://img.shields.io/badge/SQL-Window%20Functions-orange) ![Records](https://img.shields.io/badge/Records-100K-green)

---

## 📌 Project Overview

This project analyzes **100,000 bank loan records** to evaluate loan performance, identify default risk patterns, and understand borrower behavior. SQL queries were written to answer real business questions that support lending decisions and risk management strategies.

---

## 🛠️ Tools & Technologies

| Tool | Usage |
|------|-------|
| **MySQL 8.0** | Database, querying, analysis |
| **SQL** | SELECT, GROUP BY, CASE WHEN, RANK(), ROW_NUMBER() |
| **MySQL Workbench** | Query execution & data import |

---

## 📂 Dataset

| Field | Detail |
|-------|--------|
| Source | Synthetically generated realistic loan data |
| Records | 100,000 rows |
| Columns | 22 columns |
| Period | January 2018 – December 2023 |

### Key Columns
| Column | Description |
|--------|-------------|
| `loan_id` | Unique loan identifier |
| `issue_date` | Date loan was issued |
| `loan_amount` | Requested loan amount |
| `funded_amount` | Actually disbursed amount |
| `grade` | Risk grade (A = lowest risk → G = highest risk) |
| `loan_status` | Fully Paid / Current / Charged Off / Default / Late |
| `interest_rate` | Annual interest rate (%) |
| `annual_income` | Borrower's annual income |
| `dti` | Debt-to-income ratio |
| `fico_score` | Borrower credit score |
| `purpose` | Reason for loan |
| `state` | Borrower's US state |

---

## Business Questions Answered

| # | Business Question | SQL Concept |
|---|-------------------|-------------|
| 1 | Good Loan vs Bad Loan ratio | CASE WHEN, GROUP BY |
| 2 | Total loans and avg amount by grade | GROUP BY, AVG |
| 3 | Total and average loan amount by status | SUM, AVG, GROUP BY |
| 4 | Top 10 states by loan volume | ORDER BY, LIMIT |
| 5 | Most common loan purpose | GROUP BY, COUNT |
| 6 | Loans issued each year | YEAR(), GROUP BY |
| 7 | Which grade has highest default rate? | CASE WHEN, GROUP BY |
| 8 | Average interest rate by home ownership | AVG, GROUP BY |
| 9 | High value bad loans above $30,000 | WHERE, AND, ORDER BY |
| 10 | Which employment length borrows most? | AVG, GROUP BY |
| 11 | Rank loans by amount within each grade | RANK() Window Function |
| 12 | Top 3 borrowers per state by loan amount | ROW_NUMBER() Window Function |

---

## 💡 Key Findings

- **~78% of loans** are Good Loans (Fully Paid or Current)
- **Grade G** has the highest default rate (~42%) vs Grade A (~5%)
- **Debt consolidation** is the most common loan purpose (~35%)
- **CA, TX, NY** lead in total loan volume across all years
- **Loan issuance grew consistently** from 2018 to 2022
- **High-value loans (>$30K)** with bad status are concentrated in grades D–G
- **10+ year employees** tend to borrow the highest average amounts

---

## 📁 Project Structure

```
bank-loan-analysis/
│
├── dataset/
│   └── bank_loan_data.csv            → 100K row loan dataset
│
├── sql/
│   ├── 01_create_and_import.sql      → Database setup & data import
│   └── 02_business_queries.sql       → All business questions + window functions
│
└── README.md                         → Project documentation
```

---

## ▶️ How to Run

1. Open **MySQL Workbench**
2. Run `01_create_and_import.sql` → creates database and table
3. Import `bank_loan_data.csv` using **Table Data Import Wizard**
4. Run `02_business_queries.sql` → execute queries one by one
5. Each query has comments explaining the business question and SQL concept used

---

## 📸 Sample Query Output

**Good Loan vs Bad Loan**
| loan_category | total_loans |
|---------------|-------------|
| Good Loan | ~78,000 |
| Bad Loan | ~22,000 |

**Default Rate by Grade**
| grade | total_loans | default_rate_pct |
|-------|-------------|-----------------|
| G | ~3,000 | 42.00% |
| F | ~5,000 | 35.00% |
| A | ~20,000 | 5.00% |

---

## 👤 Author
**Shiva Pagidimarri**
Aspiring Data Analyst | MySQL • Python • Power BI • Excel
[LinkedIn](https://www.linkedin.com/in/pagidimarri-shiva-55b076355/) | [GitHub](https://github.com/PagidimarriShiva) | [Portfolio](https://shiva-analytics-portfolio.lovable.app/)
