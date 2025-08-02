

WITH deduplicated_departments AS (
    SELECT DISTINCT department_id, department_name
    FROM DBT_DB.SILVER.src_departments
)

SELECT
    department_id AS department_key,
    INITCAP(department_name) AS department_name
FROM deduplicated_departments