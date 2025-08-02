-- ============================================================
-- 07_create_dbt_schema.sql
-- Purpose: Create a dedicated schema for DBT models (optional)
-- ============================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;

-- Create a schema for DBT if needed for staging or testing
CREATE OR REPLACE SCHEMA DBT_SCHEMA;

-- (Optional) Grant access to allow DBT models to write
GRANT USAGE ON SCHEMA DBT_DB.DBT_SCHEMA TO ROLE DBT_ROLE;
GRANT CREATE TABLE, CREATE VIEW ON SCHEMA DBT_DB.DBT_SCHEMA TO ROLE DBT_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA DBT_DB.DBT_SCHEMA TO ROLE DBT_ROLE;

