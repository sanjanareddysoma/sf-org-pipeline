
  create or replace   view DBT_DB.SILVER.src_patients
  
   as (
    with raw_patients as (
    select *
    from DBT_DB.RAW.RAW_PATIENTS
)

select
    Patientid as patient_id,
    firstname as first_name,
    lastname as last_name,
    middlename as middle_name,
    ssn,
    phonenumber as phone_number,
    upper(gender) as gender,
    try_to_date(dob) as date_of_birth,
    address,
    try_to_date(modifieddate) as modified_date
from raw_patients
  );

