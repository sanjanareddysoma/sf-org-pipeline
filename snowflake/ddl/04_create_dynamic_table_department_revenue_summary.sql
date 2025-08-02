-- ===================================================================
-- 04_create_dynamic_table_department_revenue_summary.sql
-- Purpose: Create a dynamic table to summarize department revenue
-- ===================================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA GOLD;

CREATE OR REPLACE DYNAMIC TABLE DEPARTMENT_REVENUE_SUMMARY
  TARGET_LAG = '15 minutes'
  WAREHOUSE = DBT_WH
AS

-- Step 1: Clean transactions
WITH txn AS (
    SELECT
        department_id,
        COALESCE(charge_amount, 0) AS charge_amount,
        transaction_id
    FROM DBT_DB.SILVER.src_transactions
),

-- Step 2: Clean claims
claims AS (
    SELECT
        transaction_id,
        COALESCE(paid_amount, 0) AS paid_amount
    FROM DBT_DB.SILVER.src_claims
),

-- Step 3: Join transactions with claims and departments
joined AS (
    SELECT
        t.department_id,
        d.department_name,
        t.charge_amount,
        c.paid_amount
    FROM txn t
    LEFT JOIN claims c
        ON t.transaction_id = c.transaction_id
    LEFT JOIN DBT_DB.GOLD.dim_departments d
        ON t.department_id = d.department_key
),

-- Step 4: Aggregate metrics
aggregated AS (
    SELECT
        department_id AS department_key,
        department_name,
        COUNT(*) AS total_encounters,
        SUM(charge_amount) AS total_charges,
        SUM(paid_amount) AS total_payments,
        RANK() OVER (ORDER BY SUM(charge_amount) DESC) AS revenue_rank
    FROM joined
    GROUP BY department_id, department_name
)

-- Final output
SELECT * FROM aggregated;

-- Optional: Validate creation
SHOW DYNAMIC TABLES;

