-- ===============================================================
-- 01_debug_queries.sql
-- Purpose: General debug queries to inspect files, schemas, roles
-- ===============================================================

-- ----------------------------
-- Current session info
-- ----------------------------
SELECT CURRENT_USER(), CURRENT_ROLE(), CURRENT_WAREHOUSE(), CURRENT_DATABASE(), CURRENT_SCHEMA();

-- ----------------------------
-- External stages: List files
-- ----------------------------
SHOW STAGES IN SCHEMA DBT_DB.EXTERNAL_STAGES;

-- List files from EMR_STAGE
LIST @DBT_DB.EXTERNAL_STAGES.EMR_STAGE;

-- Peek into specific file
SELECT $1
FROM @DBT_DB.EXTERNAL_STAGES.EMR_STAGE/hospital2/patients.csv
(FILE_FORMAT => DBT_DB.FILE_FORMATS.TSV_WITH_QUOTES)
LIMIT 5;

-- ----------------------------
-- Check integration metadata
-- ----------------------------
SHOW STORAGE INTEGRATIONS;
SHOW FILE FORMATS IN SCHEMA DBT_DB.FILE_FORMATS;
SHOW GRANTS ON FILE FORMAT DBT_DB.FILE_FORMATS.CSV_FILEFORMAT;

-- ----------------------------
-- Schema/table checks
-- ----------------------------
SHOW DATABASES;
SHOW SCHEMAS IN DATABASE DBT_DB;
SHOW TABLES IN SCHEMA DBT_DB.RAW;
SHOW TABLES IN SCHEMA DBT_DB.SILVER;
SHOW TABLES IN SCHEMA DBT_DB.GOLD;

