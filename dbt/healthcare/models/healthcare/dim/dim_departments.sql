{{ config(
    materialized='table',
    schema='GOLD'
) }}

WITH deduplicated_departments AS (
    SELECT DISTINCT department_id, department_name
    FROM {{ ref('src_departments') }}
)

SELECT
    department_id AS department_key,
    INITCAP(department_name) AS department_name
FROM deduplicated_departments
