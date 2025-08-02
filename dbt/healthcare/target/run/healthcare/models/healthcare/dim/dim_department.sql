
  
    

        create or replace transient table DBT_DB.GOLD.dim_department
         as
        (

WITH deduplicated_departments AS (
    SELECT DISTINCT dept_id, name
    FROM DBT_DB.SILVER.src_departments
)

SELECT
    dept_id AS department_key,
    name AS department_name
FROM deduplicated_departments
        );
      
  