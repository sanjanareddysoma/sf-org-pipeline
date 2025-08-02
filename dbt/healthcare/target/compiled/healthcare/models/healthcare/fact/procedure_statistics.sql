

-- Step 1: Aggregate from transactions
WITH procedure_summary AS (
    SELECT
        LPAD(CAST(procedure_code AS STRING), 5, '0') AS cpt_code,
        COUNT(*) AS total_performed,
        SUM(COALESCE(charge_amount, 0)) AS total_charges
    FROM DBT_DB.SILVER.src_transactions
    WHERE procedure_code IS NOT NULL
    GROUP BY procedure_code
),

-- Step 2: Join with CPT dimension
final AS (
    SELECT
        ps.cpt_code,
        c.description,
        ps.total_performed,
        ps.total_charges,
        ROUND(ps.total_charges / NULLIF(ps.total_performed, 0), 2) AS average_charge_per_use
    FROM procedure_summary ps
    LEFT JOIN DBT_DB.GOLD.dim_cptcodes c
        ON ps.cpt_code = c.cpt_code
)

SELECT * FROM final