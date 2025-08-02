
  
    

        create or replace transient table DBT_DB.GOLD.dim_patients
         as
        (

with base as (
    select * 
    from DBT_DB.SILVER.src_patients
),

deduplicated as (
    select * 
    from base
    qualify row_number() over (partition by patient_id order by modified_date desc) = 1
),

final as (
    select
        patient_id as patient_key,
        first_name,
        last_name,
        middle_name,
        ssn,
        phone_number,
        upper(gender) as gender,
        date_of_birth,
        address,
        modified_date,

        -- Derived: age
        datediff('year', date_of_birth, current_date) as age,

        -- Derived: age_group
        case 
            when datediff('year', date_of_birth, current_date) < 18 then '0-17'
            when datediff('year', date_of_birth, current_date) between 18 and 35 then '18-35'
            when datediff('year', date_of_birth, current_date) between 36 and 60 then '36-60'
            else '60+'
        end as age_group,

        -- Derived: gender flag
        case 
            when upper(gender) like 'M%' then 'M'
            when upper(gender) like 'F%' then 'F'
            else 'U'
        end as gender_flag

    from deduplicated
)

select * from final
        );
      
  