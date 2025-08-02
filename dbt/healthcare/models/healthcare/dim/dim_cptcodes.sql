{{ config(
    materialized='table',
    schema='GOLD'
) }}

WITH cleaned_cpt AS (
    SELECT DISTINCT
        procedure_code_category AS cpt_code,               -- numeric code
        cpt_codes AS description             -- full text
    FROM {{ ref('src_cptcodes') }}
    WHERE procedure_code_category IS NOT NULL
)

SELECT * FROM cleaned_cpt
