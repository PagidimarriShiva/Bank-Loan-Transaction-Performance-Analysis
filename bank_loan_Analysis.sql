create database loan;
use loan;
-- See first 10 rows
SELECT * FROM bank_loan LIMIT 10;

-- Count total records
SELECT COUNT(*) AS total_records FROM bank_loan;

-- See all column names and types
DESCRIBE bank_loan;

-- Check unique loan statuses
SELECT DISTINCT loan_status FROM bank_loan;

-- Check unique grades
SELECT DISTINCT grade FROM bank_loan ORDER BY grade;

-- STEP 2: DATA QUALITY CHECK
-- ============================================================
-- Check for NULL values in important columns
SELECT
    COUNT(*) AS total_rows,
    COUNT(loan_amount)    AS loan_amount_filled,
    COUNT(interest_rate)  AS interest_rate_filled,
    COUNT(loan_status)    AS loan_status_filled,
    COUNT(grade)          AS grade_filled
FROM bank_loan;

-- Check for duplicate loan IDs
SELECT loan_id, COUNT(*) AS count
FROM bank_loan
GROUP BY loan_id
HAVING COUNT(*) > 1;

-- Check min and max values
SELECT
    MIN(loan_amount)    AS min_loan,
    MAX(loan_amount)    AS max_loan,
    MIN(interest_rate)  AS min_rate,
    MAX(interest_rate)  AS max_rate,
    MIN(fico_score)     AS min_fico,
    MAX(fico_score)     AS max_fico
FROM bank_loan;

-- How many loans are Good vs Bad?
-- ============================================================
SELECT
    CASE
        WHEN loan_status IN ('Fully Paid', 'Current') THEN 'Good Loan'
        ELSE 'Bad Loan'
    END AS loan_category,
    COUNT(*) AS total_loans
FROM bank_loan
GROUP BY loan_category
ORDER BY total_loans DESC;

-- How many loans are there in each grade?
-- ============================================================
SELECT
    grade,
    COUNT(*)  AS total_loans,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
    ROUND(AVG(loan_amount), 2)   AS avg_loan_amount
FROM bank_loan
GROUP BY grade
ORDER BY grade;

-- What is the total and average loan amount by loan status?
-- ============================================================
SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(SUM(loan_amount), 2)   AS total_loan_amount,
    ROUND(AVG(loan_amount), 2)   AS avg_loan_amount
FROM bank_loan
GROUP BY loan_status
ORDER BY total_loans DESC;

-- Which states have the most loans and (Top 10)
-- ============================================================
SELECT
    state,
    COUNT(*)                    AS total_loans,
    ROUND(SUM(loan_amount), 2)  AS total_amount
FROM bank_loan
GROUP BY state
ORDER BY total_loans DESC
LIMIT 10;

-- What is the most common loan purpose?
-- ============================================================
SELECT
    purpose,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amount), 2) AS avg_loan_amount
FROM bank_loan
GROUP BY purpose
ORDER BY total_loans DESC;

-- How many loans were issued each year?
-- ============================================================
SELECT
    YEAR(issue_date)  AS issue_year,
    COUNT(*)  AS total_loans,
    ROUND(SUM(loan_amount), 2)  AS total_amount_issued
FROM loa
GROUP BY issue_year
ORDER BY issue_year;

-- Which grade has the highest default rate?
-- ============================================================
SELECT
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status IN ('Charged Off', 'Default', 'Late (31-120 days)')
        THEN 1 ELSE 0 END)  AS bad_loans,
    ROUND(SUM(CASE WHEN loan_status IN ('Charged Off', 'Default', 'Late (31-120 days)')
        THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)  AS default_rate_pct
FROM bank_loan
GROUP BY grade
ORDER BY default_rate_pct DESC;

-- What is the average interest rate by home ownership?
-- ============================================================
SELECT
    home_ownership,
    COUNT(*) AS total_loans,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
    ROUND(AVG(loan_amount), 2)   AS avg_loan_amount
FROM bank_loan
GROUP BY home_ownership
ORDER BY avg_interest_rate DESC;

-- Find all high value loans above 30,000
-- with bad loan status
-- ============================================================
SELECT
    loan_id, loan_amount, grade, loan_status,
    state, annual_income
FROM bank_loan
WHERE loan_amount > 30000
  AND loan_status IN ('Charged Off', 'Default', 'Late (31-120 days)')
ORDER BY loan_amount DESC;

-- Which employment length group borrows the most?
-- ============================================================
SELECT
    emp_length,
    COUNT(*)  AS total_borrowers,
    ROUND(AVG(loan_amount), 2)   AS avg_loan_amount,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM bank_loan
GROUP BY emp_length
ORDER BY avg_loan_amount DESC;

-- Number each borrower within their state
-- ============================================================
SELECT
    loan_id,
    state,
    loan_amount,
    annual_income,
    loan_status,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY loan_amount DESC) AS row_num_in_state
FROM bank_loan
ORDER BY state, row_num_in_state
LIMIT 50;

-- Use ROW_NUMBER to get TOP 3 loans per state
-- ============================================================

SELECT *
FROM (
    SELECT
        loan_id, state,
        loan_amount, loan_status,
        ROW_NUMBER() OVER (PARTITION BY state ORDER BY loan_amount DESC) AS row_num
    FROM bank_loan
) AS ranked
WHERE row_num <= 3
ORDER BY state, row_num;





