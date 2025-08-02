
  
    

        create or replace transient table DBT_DB.GOLD.dim_providers
         as
        (

WITH base AS (
    SELECT * 
    FROM DBT_DB.SILVER.src_providers
),

deduplicated AS (
    SELECT *
    FROM base
    QUALIFY ROW_NUMBER() OVER (PARTITION BY provider_id ORDER BY npi DESC) = 1
),

final AS (
    SELECT
        provider_id,
        INITCAP(first_name) AS first_name,
        INITCAP(last_name) AS last_name,
        INITCAP(specialization) AS specialization,
        dept_id,
        npi,

        -- Derived: full name
        CONCAT(INITCAP(first_name), ' ', INITCAP(last_name)) AS full_name
    FROM deduplicated
)

SELECT * FROM final
        );
      
  