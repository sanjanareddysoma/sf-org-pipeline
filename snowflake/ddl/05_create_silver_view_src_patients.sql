-- ==================================================================
-- 05_create_silver_view_src_patients.sql
-- Purpose: Create a Silver-layer view from RAW_PATIENTS
-- ==================================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA SILVER;

-- Drop if exists (optional cleanup)
DROP VIEW IF EXISTS SRC_PATIENTS;

-- Create cleaned view for patient data
CREATE OR REPLACE VIEW SRC_PATIENTS (
    PATIENT_ID,
    FIRST_NAME,
    LAST_NAME,
    MIDDLE_NAME,
    SSN,
    PHONE_NUMBER,
    GENDER,
    DATE_OF_BIRTH,
    ADDRESS,
    MODIFIED_DATE
) AS
WITH RAW_PATIENTS_CTE AS (
    SELECT * FROM DBT_DB.RAW.RAW_PATIENTS
)
SELECT
    PatientID AS PATIENT_ID,
    FirstName AS FIRST_NAME,
    LastName AS LAST_NAME,
    MiddleName AS MIDDLE_NAME,
    SSN AS SSN,
    PhoneNumber AS PHONE_NUMBER,
    Gender AS GENDER,
    DOB AS DATE_OF_BIRTH,
    Address AS ADDRESS,
    ModifiedDate AS MODIFIED_DATE
FROM RAW_PATIENTS_CTE;

