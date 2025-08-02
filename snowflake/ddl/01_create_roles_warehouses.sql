-- ================================================
-- 01_create_roles_warehouses.sql
-- Purpose: Manage additional role privileges and warehouse access
-- ================================================

-- Set role for admin-level grants
USE ROLE ACCOUNTADMIN;

-- (Optional) Show current grants on the DBT warehouse
SHOW GRANTS ON WAREHOUSE DBT_WH;

-- Grant usage on warehouse to custom roles
GRANT USAGE ON WAREHOUSE DBT_WH TO ROLE DBT_ROLE;

-- Create Analyst Role for downstream BI or business users
CREATE OR REPLACE ROLE ANALYST_ROLE;

-- Grant read access to GOLD layer for Analyst
GRANT USAGE ON DATABASE DBT_DB TO ROLE ANALYST_ROLE;
GRANT USAGE ON SCHEMA DBT_DB.GOLD TO ROLE ANALYST_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA DBT_DB.GOLD TO ROLE ANALYST_ROLE;

-- Assign analyst role to developer/user
GRANT ROLE ANALYST_ROLE TO USER SANJANAREDDY23US;

-- Show verification of grants
SHOW GRANTS TO ROLE ANALYST_ROLE;
SHOW GRANTS ON SCHEMA DBT_DB.GOLD;

