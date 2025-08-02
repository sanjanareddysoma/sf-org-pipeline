

-- Step 1: encounter counts per patient
WITH encounter_summary AS (
    SELECT
        patient_id,
        COUNT(DISTINCT encounter_id) AS total_encounters
    FROM DBT_DB.SILVER.src_encounters
    GROUP BY patient_id
),

-- Step 2: transaction summary per patient
transaction_summary AS (
    SELECT
        patient_id,
        COUNT(*) AS total_procedures,
        SUM(COALESCE(charge_amount, 0)) AS total_charges
    FROM DBT_DB.SILVER.src_transactions
    GROUP BY patient_id
),

-- Step 3: combine metrics at patient level
combined_metrics AS (
    SELECT
        COALESCE(e.patient_id, t.patient_id) AS patient_id,
        COALESCE(total_encounters, 0) AS total_encounters,
        COALESCE(total_procedures, 0) AS total_procedures,
        COALESCE(total_charges, 0) AS total_charges
    FROM encounter_summary e
    FULL OUTER JOIN transaction_summary t
        ON e.patient_id = t.patient_id
),

-- Step 4: enrich with demographic data
final AS (
    SELECT
        cm.patient_id,
        p.first_name,
        p.last_name,
        p.gender_flag,
        p.age,
        p.age_group,
        cm.total_encounters,
        cm.total_procedures,
        cm.total_charges
    FROM combined_metrics cm
    INNER JOIN DBT_DB.GOLD.dim_patients p
        ON cm.patient_id = p.patient_key
)

SELECT * FROM final