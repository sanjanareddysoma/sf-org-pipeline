{{ config(
    materialized='table',
    schema='GOLD'
) }}

-- Step 1: Clean transaction data
WITH txn AS (
    SELECT
        department_id,
        COALESCE(CHARGE_amount, 0) AS charge_amount,
        transaction_id
    FROM {{ ref('src_transactions') }}
),

-- Step 2: Clean claims data
claims AS (
    SELECT
        transaction_id,
        COALESCE(paid_amount, 0) AS paid_amount
    FROM {{ ref('src_claims') }}
),

-- Step 3: Join transactions with claims and department dimension
joined AS (
    SELECT
        t.department_id,
        d.department_name,
        t.charge_amount,
        c.paid_amount
    FROM txn t
    LEFT JOIN claims c
        ON t.transaction_id = c.transaction_id
    LEFT JOIN {{ ref('dim_departments') }} d
        ON t.department_id = d.department_key
),

-- Step 4: Aggregate results
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

-- Step 5: Output
SELECT * FROM aggregated
