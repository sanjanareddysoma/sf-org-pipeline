
  create or replace   view DBT_DB.SILVER.src_encounters
  
   as (
    with RAW_ENCOUNTERS as (
    select * from DBT_DB.raw.raw_encounters
)

select
    -- Add encounter prefix based on patient_id
    case 
        when Provider_key like 'HOSP1-%' then 'H1-' || Encounter_ID
        when Provider_key like 'HOSP2-%' then 'H2-' || Encounter_ID
        else Encounter_ID
    end as encounter_id,

    -- Replace patient_id prefix
    replace(replace(Patient_ID, 'HOSP1-', 'H1-'), 'HOSP2-', 'H2-') as patient_id,

    Encounter_Date as encounter_date,
    Encounter_Type as encounter_type,

    -- Prefix provider_id based on patient hospital
    case 
        when Provider_key like 'HOSP1-%' then 'H1-' || Provider_ID
        when Provider_key like 'HOSP2-%' then 'H2-' || Provider_ID
        else Provider_ID
    end as provider_id,

    -- Same logic can be applied if you need to change department_id too
    case 
        when Provider_key like 'HOSP1-%' then 'H1-' || dept_id
        when Provider_key like 'HOSP2-%' then 'H2-' || dept_id
        else dept_id
    end as dept_id,
    

    Procedure_Code as procedure_code,
    Inserted_Date as inserted_date,
    Modified_Date as modified_date
from RAW_ENCOUNTERS
  );

