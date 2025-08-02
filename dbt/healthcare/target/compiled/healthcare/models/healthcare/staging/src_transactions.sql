with RAW_TRANSACTIONS as (
    select * from DBT_DB.raw.raw_transactions
)

select
    -- Add transaction prefix based on patient_id
    case 
        when hospitalid like 'HOSP1' then 'H1-' || TransactionID
        when hospitalid like 'HOSP2' then 'H2-' || TransactionID
        else TransactionID
    end as transaction_id,

    -- Add encounter prefix based on patient_id
    case 
        when hospitalid like 'HOSP1' then 'H1-' || EncounterID
        when hospitalid like 'HOSP2' then 'H2-' || EncounterID
        else EncounterID
    end as encounter_id,

    case 
        when HospitalID = 'HOSP1' then replace(PatientID, 'HOSP1-', 'H1-')
        when HospitalID = 'HOSP2' then replace(PatientID, 'HOSP1-', 'H2-')  -- assumes HOSP2 patients are still labeled with HOSP1-
        else PatientID
    end as patient_id,
    -- Add provider_id prefix based on patient_id
    case 
        when hospitalid like 'HOSP1' then 'H1-' || ProviderID
        when hospitalid like 'HOSP2' then 'H2-' || ProviderID
        else ProviderID
    end as provider_id,

    -- Add provider_id prefix based on patient_id
    case 
        when hospitalid like 'HOSP1' then 'H1-' || DepartmentID
        when hospitalid like 'HOSP2' then 'H2-' || DepartmentID
        else DepartmentID
    end as Department_id,


    visitdate as visit_date,
    serviceDate as service_date,
    paidDate as paid_date,
    visittype as visit_type,
    amount as charge_amount,
    amounttype as amount_type,
    paidamount as paid_amount,

    -- Same logic can be applied if you need to change department_id too
    case 
        when hospitalid like 'HOSP1' then 'H1-' || claimid
        when hospitalid like 'HOSP2' then 'H2-' || claimid
        else claimid
    end as claim_id,

    payorid as payor_id,
    procedurecode as procedure_code,
    icdcode as icd_code,
    lineofbusiness as line_of_business,
    medicaidid as medica_id,
    medicareid as medicare_id,
    insertdate as inserted_date,
    modifieddate as modified_date


from RAW_TRANSACTIONS