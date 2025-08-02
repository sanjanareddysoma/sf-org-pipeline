
  
    

        create or replace transient table DBT_DB.GOLD.provider_performance_summary
         as
        (

WITH encounter_counts AS (
    SELECT
        provider_id,
        COUNT(DISTINCT encounter_id) AS total_encounters
    FROM DBT_DB.SILVER.src_encounters
    GROUP BY provider_id
),

transaction_sums AS (
    SELECT
        provider_id,
        SUM(COALESCE(charge_amount, 0)) AS total_charges
    FROM DBT_DB.SILVER.src_transactions
    GROUP BY provider_id
),

claims_with_providers AS (
    SELECT
        t.provider_id,
        SUM(COALESCE(c.paid_amount, 0)) AS total_payments
    FROM DBT_DB.SILVER.src_transactions t
    LEFT JOIN DBT_DB.SILVER.src_claims c
        ON t.transaction_id = c.transaction_id
    GROUP BY t.provider_id
),

combined_metrics AS (
    SELECT
        COALESCE(e.provider_id, t.provider_id, c.provider_id) AS provider_id,
        COALESCE(total_encounters, 0) AS total_encounters,
        COALESCE(total_charges, 0) AS total_charges,
        COALESCE(total_payments, 0) AS total_payments
    FROM encounter_counts e
    FULL OUTER JOIN transaction_sums t ON e.provider_id = t.provider_id
    FULL OUTER JOIN claims_with_providers c ON COALESCE(e.provider_id, t.provider_id) = c.provider_id
),

final AS (
    SELECT
        cm.provider_id,
        p.full_name,
        p.specialization,
        p.dept_id,
        cm.total_encounters,
        cm.total_charges,
        cm.total_payments,
        ROUND(CASE 
            WHEN cm.total_encounters > 0 THEN cm.total_charges / cm.total_encounters
            ELSE NULL
        END, 2) AS avg_charge_per_encounter
    FROM combined_metrics cm
    INNER JOIN DBT_DB.GOLD.dim_providers p
        ON cm.provider_id = p.provider_id
)

SELECT * FROM final
        );
      
  