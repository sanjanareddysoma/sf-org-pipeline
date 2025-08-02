{{ config(
    materialized='table',
    schema='GOLD'
) }}

SELECT
    provider_id,
    COUNT(*) AS occurrence_count,
    'encounters' AS source_table
FROM {{ ref('src_encounters') }}
WHERE provider_id NOT IN (SELECT provider_id FROM {{ ref('dim_providers') }})
GROUP BY provider_id

UNION ALL

SELECT
    provider_id,
    COUNT(*) AS occurrence_count,
    'transactions' AS source_table
FROM {{ ref('src_transactions') }}
WHERE provider_id NOT IN (SELECT provider_id FROM {{ ref('dim_providers') }})
GROUP BY provider_id
