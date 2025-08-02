-- ===============================================================
-- 07_load_cptcodes.sql
-- Purpose: Load CPT (procedure code) reference data into RAW.CPTCODES
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE CPTCODES;

-- ----------------------------
-- Load CPT Codes from Azure Stage
-- ----------------------------
COPY INTO CPTCODES
FROM @DBT_DB.EXTERNAL_STAGES.CPTCODES_STAGE
FILE_FORMAT = (
  FORMAT_NAME = 'DBT_DB.FILE_FORMATS.CSV_WITH_QUOTES'
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
)
ON_ERROR = 'CONTINUE';

-- Validate load
SELECT COUNT(*) AS total_cptcodes FROM CPTCODES;

