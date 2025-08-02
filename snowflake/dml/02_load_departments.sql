-- ===============================================================
-- 02_load_departments.sql
-- Purpose: Load department data and generate department_key
-- ===============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Optional cleanup
TRUNCATE TABLE RAW_DEPARTMENTS;

-- ----------------------------
-- Load Hospital 1 Departments
-- ----------------------------
COPY INTO RAW_DEPARTMENTS
FROM (
    SELECT
        $1 AS department_id,
        $2 AS department_name,
        'HOSP1' AS hospital_id,
        CONCAT('HOSP1-', $1) AS department_key
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital1/departments.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT);

-- ----------------------------
-- Load Hospital 2 Departments
-- ----------------------------
COPY INTO RAW_DEPARTMENTS
FROM (
    SELECT
        $1 AS department_id,
        $2 AS department_name,
        'HOSP2' AS hospital_id,
        CONCAT('HOSP2-', $1) AS department_key
    FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital2/departments.csv
)
FILE_FORMAT = (FORMAT_NAME => DBT_DB.FILE_FORMATS.CSV_FILEFORMAT);

-- Validate load
SELECT hospital_id, COUNT(*) AS total_departments
FROM RAW_DEPARTMENTS
GROUP BY hospital_id;

