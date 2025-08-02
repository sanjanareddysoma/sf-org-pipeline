

WITH txn AS (
    SELECT
        provider_id,
        department_id,
        COALESCE(charge_amount, 0) AS charge_amount
    FROM DBT_DB.SILVER.src_transactions
),

providers AS (
    SELECT
        provider_id,
        full_name,
        specialization
    FROM DBT_DB.GOLD.dim_providers
),

departments AS (
    SELECT
        department_key,
        department_name
    FROM DBT_DB.GOLD.dim_departments
),

joined AS (
    SELECT
        t.provider_id,
        p.full_name,
        p.specialization,
        t.department_id,
        d.department_name,
        t.charge_amount
    FROM txn t
    LEFT JOIN providers p ON t.provider_id = p.provider_id
    LEFT JOIN departments d ON t.department_id = d.department_key
),

aggregated AS (
    SELECT
        provider_id,
        full_name,
        specialization,
        department_id,
        department_name,
        SUM(charge_amount) AS total_charges,
        COUNT(*) AS total_visits
    FROM joined
    GROUP BY provider_id, full_name, specialization, department_id, department_name
)

SELECT * FROM aggregated