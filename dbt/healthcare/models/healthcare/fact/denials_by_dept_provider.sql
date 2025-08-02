{{ config(
    materialized='table',
    schema='GOLD'
) }}

with base as (
    select
        provider_id,
        dept_id,
        claim_status
    from {{ ref('src_claims') }}
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
left join {{ ref('dim_providers') }} p on a.provider_id = p.provider_id
left join {{ ref('dim_departments') }} d on a.dept_id = d.department_key
order by denial_count desc
