-- ===============================================================
-- 06_load_claims.sql
-- Purpose: Load claim records into RAW_CLAIMS from Azure stage
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE RAW_CLAIMS;

-- ----------------------------
-- Load Hospital 2 Claims
-- ----------------------------
COPY INTO RAW_CLAIMS (
    claim_id,
    transaction_id,
    patient_id,
    hospital_id,
    encounter_id,
    provider_id,
    dept_id,
    service_date,
    claim_date,
    payor_id,
    claim_amount,
    paid_amount,
    claim_status,
    payor_type,
    deductible,
    coinsurance,
    copay,
    insert_date,
    modified_date
)
FROM (
    SELECT 
        t.$1, t.$2, t.$3, 'HOSP2', t.$4, t.$5, t.$6, t.$7, t.$8,
        t.$9, t.$10, t.$11, t.$12, t.$13, t.$14, t.$15, t.$16, t.$17, t.$18
    FROM @DBT_DB.EXTERNAL_STAGES.CLAIMS_STAGE/hospital2_claim_data.csv (FILE_FORMAT => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT) t
)
ON_ERROR = 'CONTINUE';

-- ----------------------------
-- Load Hospital 1 Claims (if exists)
-- ----------------------------
COPY INTO RAW_CLAIMS
FROM @DBT_DB.EXTERNAL_STAGES.CLAIMS_STAGE
FILES = ('hospital1_claim_data.csv')
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT)
ON_ERROR = 'CONTINUE';

-- Validate load
SELECT hospital_id, COUNT(*) AS total_claims
FROM RAW_CLAIMS
GROUP BY hospital_id;

