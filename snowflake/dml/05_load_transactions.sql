-- ===============================================================
-- 05_load_transactions.sql
-- Purpose: Load transaction records into RAW_TRANSACTIONS
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE RAW_TRANSACTIONS;

-- ----------------------------
-- Load Hospital 2 Transactions
-- ----------------------------
COPY INTO RAW_TRANSACTIONS (
    TransactionID,
    EncounterID,
    PatientID,
    ProviderID,
    HospitalID,
    DepartmentID,
    VisitDate,
    ServiceDate,
    PaidDate,
    VisitType,
    Amount,
    AmountType,
    PaidAmount,
    ClaimID,
    PayorID,
    ProcedureCode,
    ICDCode,
    LineOfBusiness,
    MedicaidID,
    MedicareID,
    InsertDate,
    ModifiedDate
)
FROM (
    SELECT 
        $1, $2, $3, $4, 'HOSP2', $5, $6, $7, $8, $9,
        $10, $11, $12, $13, $14, $15, $16, $17, $18, $19,
        $20, $21
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital2/transactions.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT)
ON_ERROR = 'CONTINUE';

-- ----------------------------
-- Load Hospital 1 Transactions (if exists)
-- ----------------------------
COPY INTO RAW_TRANSACTIONS
FROM @DBT

