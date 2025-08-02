with RAW_PROVIDERS as (
    select * from DBT_DB.RAW.RAW_PROVIDERS
)

select
    Provider_ID as provider_id,
    First_Name as first_name,
    Last_Name as last_name,
    Specialization as specialization,
    DEPT_ID as dept_id,
    NPI as npi,
    
    case 
        when split_part(DEPARTMENT_KEY, '-', 1) = 'HOSP1' then 'H1'
        when split_part(DEPARTMENT_KEY, '-', 1) = 'HOSP2' then 'H2'
        else 'UNKNOWN'
    end as hospital_code

from RAW_PROVIDERS