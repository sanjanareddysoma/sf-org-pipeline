
  create or replace   view DBT_DB.SILVER.src_cptcodes
  
   as (
    WITH RAW_CPTCODES AS (

    SELECT *
    FROM DBT_DB.RAW.RAW_CPTCODES

)

SELECT
    INDEX                       AS index,
    PROCEDURE_CODE_CATEGORY     AS procedure_code_category,
    CPT_CODES                   AS cpt_codes,
    PROCEDURE_CODE_DESCRIPTIONS AS procedure_code_descriptions,
    CODE_STATUS                 AS code_status

FROM RAW_CPTCODES
  );

