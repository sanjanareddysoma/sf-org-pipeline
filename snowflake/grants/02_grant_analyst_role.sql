-- ===============================================================
-- 02_grant_analyst_role.sql
-- Purpose: Grant read-only access to GOLD layer for Analyst role
-- ===============================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE DBT_DB;

-- Ensure role exists (safe to re-run)
CREATE OR REPLACE ROLE ANALYST_ROLE;

-- Grant visibility and access on GOLD layer
GRANT USAGE ON DATABASE DBT_DB TO ROLE ANALYST_ROLE;
GRANT USAGE ON SCHEMA DBT_DB.GOLD TO ROLE ANALYST_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA DBT_DB.GOLD TO ROLE ANALYST_ROLE;
GRANT SELECT ON FUTURE TABLES IN SCHEMA DBT_DB.GOLD TO ROLE ANALYST_ROLE;

-- Assign analyst role to user
GRANT ROLE ANALYST_ROLE TO USER SANJANAREDDY23US;

-- Validate grants
SHOW GRANTS TO ROLE ANALYST_ROLE;

