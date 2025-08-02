-- ===============================================================
-- 03_load_providers.sql
-- Purpose: Load provider data and attach department keys
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE RAW_PROVIDERS;

-- ----------------------------
-- Load Hospital 1 Providers
-- ----------------------------
COPY INTO RAW_PROVIDERS
FROM (
    SELECT
        $1 AS provider_id,
        $2 AS first_name,
        $3 AS last_name,
        $4 AS specialization,
        $5 AS dept_id,
        CONCAT('HOSP1-', $5) AS department_key,
        $6 AS npi
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital1/providers.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT);

-- ----------------------------
-- Load Hospital 2 Providers
-- ----------------------------
COPY INTO RAW_PROVIDERS
FROM (
    SELECT
        $1 AS provider_id,
        $2 AS first_name,
        $3 AS last_name,
        $4 AS specialization,
        $5 AS dept_id,
        CONCAT('HOSP2-', $5) AS department_key,
        $6 AS npi
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital2/providers.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT);

-- Validate load
SELECT COUNT(*) AS total_providers FROM RAW_PROVIDERS;

