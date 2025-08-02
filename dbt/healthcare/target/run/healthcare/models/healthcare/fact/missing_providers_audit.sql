
  
    

        create or replace transient table DBT_DB.GOLD.missing_providers_audit
         as
        (

SELECT
    provider_id,
    COUNT(*) AS occurrence_count,
    'encounters' AS source_table
FROM DBT_DB.SILVER.src_encounters
WHERE provider_id NOT IN (SELECT provider_id FROM DBT_DB.GOLD.dim_providers)
GROUP BY provider_id

UNION ALL

SELECT
    provider_id,
    COUNT(*) AS occurrence_count,
    'transactions' AS source_table
FROM DBT_DB.SILVER.src_transactions
WHERE provider_id NOT IN (SELECT provider_id FROM DBT_DB.GOLD.dim_providers)
GROUP BY provider_id
        );
      
  