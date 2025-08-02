
  create or replace   view DBT_DB.SILVER.src_departments
  
   as (
    with RAW_DEPARTMENTS as (
    select * from DBT_DB.RAW.RAW_DEPARTMENTS
)
select
    
    -- Add encounter prefix based on patient_id
    case 
        when Hospital_id like 'HOSP1' then 'H1-' || DEPARTMENT_ID
        when Hospital_id like 'HOSP2' then 'H2-' || DEPARTMENT_ID
        else Department_id
    end as department_id,
    
    DEPARTMENT_Name as department_name
from RAW_DEPARTMENTS
  );

