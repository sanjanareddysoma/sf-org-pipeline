-- ========================================
-- 00_initialize_snowflake_env.sql
-- Purpose: Set up initial Snowflake environment
-- Includes: Warehouse, database, role, user
-- ========================================

-- Set admin role
USE ROLE ACCOUNTADMIN;

-- Create warehouse for DBT processing
CREATE OR REPLACE WAREHOUSE DBT_WH
    WAREHOUSE_SIZE = 'X-SMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Warehouse for DBT data transformations';

-- Create primary database for project
CREATE OR REPLACE DATABASE DBT_DB
    COMMENT = 'Healthcare analytics database for EMR and claims integration';

-- Create DBT role
CREATE OR REPLACE ROLE DBT_ROLE;

-- Create user for developer (optional; use your real username)
CREATE OR REPLACE USER SANJANA;

-- Grant access privileges
GRANT USAGE ON WAREHOUSE DBT_WH TO ROLE DBT_ROLE;
GRANT ALL PRIVILEGES ON DATABASE DBT_DB TO ROLE DBT_ROLE;
GRANT ROLE DBT_ROLE TO USER SANJANA;
GRANT ROLE DBT_ROLE TO USER SANJANAREDDY23US;

-- Switch to DBT_ROLE to verify
USE ROLE DBT_ROLE;
SELECT CURRENT_USER(), CURRENT_ROLE();

