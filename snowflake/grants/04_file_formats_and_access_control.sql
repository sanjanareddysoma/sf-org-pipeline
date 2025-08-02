-- =======================================================================
-- 04_file_formats_and_access_control.sql
-- Purpose: Grant access to file formats and external stages for roles
-- =======================================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE DBT_DB;

-- ----------------------------
-- Grant access to FILE_FORMATS schema
-- ----------------------------
GRANT USAGE ON SCHEMA DBT_DB.FILE_FORMATS TO ROLE ACCOUNTADMIN;
GRANT USAGE ON ALL FILE FORMATS IN SCHEMA DBT_DB.FILE_FORMATS TO ROLE ACCOUNTADMIN;
GRANT USAGE ON FUTURE FILE FORMATS IN SCHEMA DBT_DB.FILE_FORMATS TO ROLE ACCOUNTADMIN;

-- Optional: allow DBT_ROLE to use file formats
GRANT USAGE ON SCHEMA DBT_DB.FILE_FORMATS TO ROLE DBT_ROLE;
GRANT USAGE ON ALL FILE FORMATS IN SCHEMA DBT_DB.FILE_FORMATS TO ROLE DBT_ROLE;

-- ----------------------------
-- General database and schema access for DBT_ROLE
-- ----------------------------
GRANT USAGE ON DATABASE DBT_DB TO ROLE DBT_ROLE;
GRANT USAGE ON SCHEMA DBT_DB.RAW TO ROLE DBT_ROLE;
GRANT USAGE ON SCHEMA DBT_DB.SILVER TO ROLE DBT_ROLE;

-- Grant read access to RAW data
GRANT SELECT ON ALL TABLES IN SCHEMA DBT_DB.RAW TO ROLE DBT_ROLE;
GRANT SELECT ON FUTURE TABLES IN SCHEMA DBT_DB.RAW TO ROLE DBT_ROLE;

-- Allow view/table creation in SILVER
GRANT CREATE TABLE, CREATE VIEW ON SCHEMA DBT_DB.SILVER TO ROLE DBT_ROLE;

-- ----------------------------
-- Validation queries
-- ----------------------------
SHOW FILE FORMATS IN SCHEMA DBT_DB.FILE_FORMATS;
SHOW STAGES IN SCHEMA DBT_DB.EXTERNAL_STAGES;

