-- ===============================================================
-- 04_load_encounters.sql
-- Purpose: Load patient encounter records with key transformations
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE RAW_ENCOUNTERS;

-- ----------------------------
-- Load Hospital 1 Encounters
-- ----------------------------
COPY INTO RAW_ENCOUNTERS
FROM (
    SELECT
        $1 AS encounter_id,
        $2 AS patient_id,
        CONCAT('HOSP1-', $2) AS patient_key,
        TRY_CAST($3 AS DATE) AS encounter_date,
        $4 AS encounter_type,
        $5 AS provider_id,
        CONCAT('HOSP1-', $5) AS provider_key,
        $6 AS dept_id,
        CONCAT('HOSP1-', $6) AS department_key,
        $7 AS procedure_code,
        TRY_CAST($8 AS DATE) AS inserted_date,
        TRY_CAST($9 AS DATE) AS modified_date
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital1/encounters.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT);

-- ----------------------------
-- Load Hospital 2 Encounters
-- ----------------------------
COPY INTO RAW_ENCOUNTERS
FROM (
    SELECT
        $1 AS encounter_id,
        $2 AS patient_id,
        CONCAT('HOSP2-', $2) AS patient_key,
        TRY_CAST($3 AS DATE) AS encounter_date,
        $4 AS encounter_type,
        $5 AS provider_id,
        CONCAT('HOSP2-', $5) AS provider_key,
        $6 AS dept_id,
        CONCAT('HOSP2-', $6) AS department_key,
        $7 AS procedure_code,
        TRY_CAST($8 AS DATE) AS inserted_date,
        TRY_CAST($9 AS DATE) AS modified_date
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital2/encounters.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT);

-- Grant FK usage (optional, if enforcing constraints later)
GRANT REFERENCES ON TABLE RAW_ENCOUNTERS TO ROLE DBT_ROLE;

-- Validate
SELECT COUNT(*) AS total_encounters FROM RAW_ENCOUNTERS;

