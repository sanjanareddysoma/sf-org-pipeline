

with txn as (
    select
        provider_id,
        transaction_id,
        coalesce(charge_amount, 0) as billed_amount
    from DBT_DB.SILVER.src_transactions
),

claims as (
    select
        transaction_id,
        coalesce(paid_amount, 0) as paid_amount
    from DBT_DB.SILVER.src_claims
),

joined as (
    select
        t.provider_id,
        t.transaction_id,
        t.billed_amount,
        c.paid_amount
    from txn t
    left join claims c
        on t.transaction_id = c.transaction_id
),

aggregated as (
    select
        provider_id,
        count(*) as total_transactions,
        sum(billed_amount) as total_billed,
        sum(paid_amount) as total_paid,
        sum(greatest(billed_amount - paid_amount, 0)) as ar_balance
    from joined
    group by provider_id
),

with_provider_details as (
    select
        a.provider_id,
        p.full_name,
        p.specialization,
        a.total_transactions,
        a.total_billed,
        a.total_paid,
        a.ar_balance
    from aggregated a
    left join DBT_DB.GOLD.dim_providers p
        on a.provider_id = p.provider_id
)

select * from with_provider_details