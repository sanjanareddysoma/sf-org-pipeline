
  
    

        create or replace transient table DBT_DB.GOLD.denials_by_dept_provider
         as
        (

with base as (
    select
        provider_id,
        dept_id,
        claim_status
    from DBT_DB.SILVER.src_claims
    where upper(claim_status) = 'DENIED'
),

agg as (
    select
        provider_id,
        dept_id,
        count(*) as denial_count
    from base
    group by provider_id, dept_id
)

select 
    a.provider_id,
    p.full_name,
    p.specialization,
    a.dept_id,
    d.department_name,
    a.denial_count
from agg a
left join DBT_DB.GOLD.dim_providers p on a.provider_id = p.provider_id
left join DBT_DB.GOLD.dim_departments d on a.dept_id = d.department_key
order by denial_count desc
        );
      
  