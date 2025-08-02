
  
    

        create or replace transient table DBT_DB.GOLD.dim_cptcodes
         as
        (

WITH cleaned_cpt AS (
    SELECT DISTINCT
        procedure_code_category AS cpt_code,               -- numeric code
        cpt_codes AS description             -- full text
    FROM DBT_DB.SILVER.src_cptcodes
    WHERE procedure_code_category IS NOT NULL
)

SELECT * FROM cleaned_cpt
        );
      
  