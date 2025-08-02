
  
    

        create or replace transient table DBT_DB.GOLD.claims_status_metrics
         as
        (

with base as (
    select
        claim_status,
        try_to_date(claim_date) as claim_date
    from DBT_DB.SILVER.src_claims
    where claim_status is not null
),

agg as (
    select
        to_char(claim_date, 'YYYY-MM') as claim_month,
        upper(claim_status) as claim_status,
        count(*) as claim_count
    from base
    group by claim_month, claim_status
)

select * from agg
order by claim_month, claim_status
        );
      
  