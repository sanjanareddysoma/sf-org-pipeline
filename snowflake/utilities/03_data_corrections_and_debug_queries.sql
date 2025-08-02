-- ========================================================================
-- 03_data_corrections_and_debug_queries.sql
-- Purpose: Fix data quality issues and inspect record formatting problems
-- ========================================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- ----------------------------
-- Fix: Update incorrectly prefixed patient IDs for HOSP2
-- ----------------------------
UPDATE RAW_PATIENTS
SET PatientID = REPLACE(PatientID, 'HOSP1-', 'HOSP2-')
WHERE PatientID LIKE 'HOSP1-%' AND HospitalID = 'HOSP2';

-- ----------------------------
-- Fix: Remove over-prefixed patient IDs
-- ----------------------------
UPDATE RAW_PATIENTS
SET PatientID = REPLACE(PatientID, 'HOSP2-', 'H2-')
WHERE PatientID LIKE 'HOSP2-%';

-- ----------------------------
-- Drop incorrectly created key column
-- ----------------------------
ALTER TABLE RAW_ENCOUNTERS DROP COLUMN IF EXISTS PATIENT_KEY;

-- ----------------------------
-- Duplicate and null checks
-- ----------------------------
SELECT CLAIM_ID, COUNT(*) AS claim_count
FROM RAW_CLAIMS
GROUP BY CLAIM_ID
HAVING COUNT(*) > 1;

SELECT * FROM RAW_CLAIMS WHERE CLAIM_ID IN ('CLAIM000001', 'CLAIM000002');

-- ----------------------------
-- Sample data checks
-- ----------------------------
SELECT * FROM RAW_DEPARTMENTS WHERE DEPTID LIKE 'DEPT001' OR DEPTID LIKE 'DEPT002';
SELECT * FROM RAW_ENCOUNTERS WHERE ENCOUNTER_ID = 'ENC000001';
SELECT * FROM RAW_TRANSACTIONS WHERE HOSPITALID = 'HOSP2' LIMIT 3;

