

SELECT
    provider_id,
    COUNT(DISTINCT patient_id) AS unique_patients_seen,
    COUNT(*) AS total_transactions,
    SUM(charge_amount) AS total_billed_amount
FROM DBT_DB.SILVER.src_transactions
GROUP BY provider_id