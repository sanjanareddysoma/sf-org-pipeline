-- ======================================================================
-- 05_silver_patients_data_validation.sql
-- Purpose: Validate Silver layer patient records for integrity and errors
-- ======================================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA SILVER;

-- ----------------------------
-- 1. Check for null patient IDs
-- ----------------------------
SELECT COUNT(*) AS null_patient_ids
FROM SRC_PATIENTS
WHERE PATIENT_ID IS NULL;

-- ----------------------------
-- 2. Check for duplicate patient IDs
-- ----------------------------
SELECT PATIENT_ID, COUNT(*) AS duplicate_count
FROM SRC_PATIENTS
GROUP BY PATIENT_ID
HAVING COUNT(*) > 1;

-- ----------------------------
-- 3. Explore duplicate samples
-- ----------------------------
SELECT *
FROM SRC_PATIENTS
WHERE PATIENT_ID IN ('HOSP1-000001', 'HOSP1-000002');

-- ----------------------------
-- 4. Check for invalid or suspicious date of birth
-- (Future dates or patients > 120 years old)
-- ----------------------------
SELECT *
FROM SRC_PATIENTS
WHERE TRY_TO_DATE(DATE_OF_BIRTH) > CURRENT_DATE
   OR DATEDIFF('YEAR', TRY_TO_DATE(DATE_OF_BIRTH), CURRENT_DATE) > 120;

