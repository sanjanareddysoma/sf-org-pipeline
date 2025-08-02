
  create or replace   view DBT_DB.SILVER.src_claims
  
   as (
    with RAW_CLAIMS as (
    select * from DBT_DB.RAW.RAW_CLAIMS
)

select
-- Add CLAIMID prefix based on patient_id
    case 
        when Hospital_id like 'HOSP1' then 'H1-' || CLAIM_ID
        when Hospital_id like 'HOSP2' then 'H2-' || CLAIM_ID
        else CLAIM_ID
    end as CLAIM_ID,
    
-- Add CLAIMID prefix based on patient_id
    case 
        when Hospital_id like 'HOSP1' then 'H1-' || TRANSACTION_ID
        when Hospital_id like 'HOSP2' then 'H2-' || TRANSACTION_ID
        else TRANSACTION_ID
    end as transaction_id,

    case 
        when Hospital_ID = 'HOSP1' then replace(Patient_ID, 'HOSP1-', 'H1-')
        when Hospital_ID = 'HOSP2' then replace(Patient_ID, 'HOSP1-', 'H2-')  -- assumes HOSP2 patients are still labeled with HOSP1-
        else Patient_ID
    end as patient_id,
    
    -- Add ENCOUNTERID prefix based on patient_id
    case 
        when Hospital_id like 'HOSP1' then 'H1-' || ENCOUNTER_ID
        when Hospital_id like 'HOSP2' then 'H2-' || ENCOUNTER_ID
        else ENCOUNTER_ID
    end as encounter_id,

    -- Add PROVIDERID prefix based on patient_id
    case 
        when Hospital_id like 'HOSP1' then 'H1-' || PROVIDER_ID
        when Hospital_id like 'HOSP2' then 'H2-' || PROVIDER_ID
        else PROVIDER_ID
    end as provider_id,

    -- Add deptID prefix based on patient_id
    case 
        when Hospital_id like 'HOSP1' then 'H1-' || DEPT_ID
        when Hospital_id like 'HOSP2' then 'H2-' || DEPT_ID
        else DEPT_ID
    end as dept_id,

    SERVICE_DATE           AS service_date, 
    CLAIM_DATE            AS claim_date,
    PAYOR_ID              AS payor_id,
    CLAIM_AMOUNT          AS claim_amount,
    PAID_AMOUNT           AS paid_amount,
    CLAIM_STATUS          AS claim_status,
    PAYOR_TYPE            AS payor_type,
    DEDUCTIBLE         AS deductible,
    COINSURANCE           AS coinsurance,
    COPAY                 AS copay,
    INSERT_DATE            AS insert_date,
    MODIFIED_DATE          AS modified_date
from RAW_CLAIMS
  );

