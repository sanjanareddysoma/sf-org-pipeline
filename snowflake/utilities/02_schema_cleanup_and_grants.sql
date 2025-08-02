-- ===============================================================
-- 02_schema_cleanup_and_grants.sql
-- Purpose: Drop unused schemas, transfer ownership, and cleanup views
-- ===============================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE DBT_DB;

-- ----------------------------
-- Drop accidental or unused schema
-- ----------------------------
DROP SCHEMA IF EXISTS DBT_DB.SILVER_GOLD;

-- Drop leftover table if present
DROP TABLE IF EXISTS DBT_DB.SILVER_GOLD.DIM_PATIENTS;

-- ----------------------------
-- Transfer ownership of SILVER schema to ACCOUNTADMIN
-- Required for revoking/cleaning up roles
-- ----------------------------
GRANT OWNERSHIP ON SCHEMA DBT_DB.SILVER TO ROLE ACCOUNTADMIN REVOKE CURRENT GRANTS;

-- ----------------------------
-- Drop view from SILVER if needed
-- ----------------------------
USE ROLE DBT_ROLE;
DROP VIEW IF EXISTS DBT_DB.SILVER.SRC_TRANSACTIONS;

