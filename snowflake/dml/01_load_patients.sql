-- ===============================================================
-- 01_load_patients.sql
-- Purpose: Load patient data from both hospitals into RAW_PATIENTS
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE RAW_PATIENTS;

-- ----------------------------
-- Load Hospital 1 Patients
-- ----------------------------
COPY INTO RAW_PATIENTS
FROM (
  SELECT 
    $1, $2, $3, $4, $5, $6, $7, TO_DATE($8), $9, TO_DATE($10),
    'HOSP1'
  FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital1/patients.csv
)
FILE_FORMAT = (FORMAT_NAME = DBT_DB.FILE_FORMATS.CSV_WITH_QUOTES)
ON_ERROR = 'CONTINUE';

-- ----------------------------
-- Load Hospital 2 Patients
-- ----------------------------
COPY INTO RAW_PATIENTS
FROM (
  SELECT 
    $1, $2, $3, $4, $5, $6, $7, TO_DATE($8), $9, TO_DATE($10),
    'HOSP2'
  FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital2/patients.csv
)
FILE_FORMAT = (FORMAT_NAME = DBT_DB.FILE_FORMATS.CSV_WITH_QUOTES)
ON_ERROR = 'CONTINUE'
FORCE = TRUE;

-- Validate load
SELECT HOSPITALID, COUNT(*) AS total_records
FROM RAW_PATIENTS
GROUP BY HOSPITALID;

