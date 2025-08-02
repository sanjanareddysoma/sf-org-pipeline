========================================================================
-- 06_create_file_formats_and_external_stages.sql
-- Purpose: Define file formats and configure external stages for loading data
-- ========================================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE DBT_DB;

-- Create supporting schemas if not already present
CREATE SCHEMA IF NOT EXISTS DBT_DB.FILE_FORMATS;
CREATE SCHEMA IF NOT EXISTS DBT_DB.EXTERNAL_STAGES;

-- =============================
-- 📄 FILE FORMATS
-- =============================

-- Basic CSV format (no quotes)
CREATE OR REPLACE FILE FORMAT DBT_DB.FILE_FORMATS.CSV_FILEFORMAT
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    EMPTY_FIELD_AS_NULL = TRUE;

-- TSV with quoted fields
CREATE OR REPLACE FILE FORMAT DBT_DB.FILE_FORMATS.TSV_WITH_QUOTES
    TYPE = 'CSV'
    FIELD_DELIMITER = '\t'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    EMPTY_FIELD_AS_NULL = TRUE;

-- CSV with quoted fields
CREATE OR REPLACE FILE FORMAT DBT_DB.FILE_FORMATS.CSV_WITH_QUOTES
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    EMPTY_FIELD_AS_NULL = TRUE;

