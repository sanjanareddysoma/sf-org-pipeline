-- ===============================================================
-- 03_show_grants.sql
-- Purpose: Utility script to inspect current grants and roles
-- ===============================================================

-- Who am I?
SELECT CURRENT_USER(), CURRENT_ROLE(), CURRENT_ACCOUNT();

-- Show all roles granted to a user
SHOW ROLES GRANTED TO USER SANJANAREDDY23US;

-- Show privileges on a specific schema
SHOW GRANTS ON SCHEMA DBT_DB.RAW;
SHOW GRANTS ON SCHEMA DBT_DB.SILVER;
SHOW GRANTS ON SCHEMA DBT_DB.GOLD;

-- Show privileges on a specific table or view
SHOW GRANTS ON TABLE DBT_DB.RAW.RAW_PATIENTS;
SHOW GRANTS ON VIEW DBT_DB.SILVER.SRC_PATIENTS;

-- Show all roles and their assigned users
SHOW GRANTS TO ROLE DBT_ROLE;
SHOW GRANTS TO ROLE ANALYST_ROLE;

-- Show grants on file formats (if applicable)
SHOW GRANTS ON FILE FORMAT DBT_DB.FILE_FORMATS.CSV_FILEFORMAT;

-- Show warehouse grants
SHOW GRANTS ON WAREHOUSE DBT_WH;

