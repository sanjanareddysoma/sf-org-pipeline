-- =============================================================================
-- 04_silver_layer_data_validation.sql
-- Purpose: Run quality and integrity checks on Silver layer tables
-- =============================================================================

USE ROLE DBT_ROLE;
USE DATABASE DBT_DB;

-- =============================
-- 🔍 PROVIDERS VALIDATION
-- =============================

-- Duplicate provider IDs
SELECT provider_id, COUNT(*) 
FROM SILVER.SRC_PROVIDERS 
GROUP BY provider_id 
HAVING COUNT(*) > 1;

-- Missing critical fields
SELECT COUNT(*) 
FROM SILVER.SRC_PROVIDERS
WHERE provider_id IS NULL OR first_name IS NULL OR last_name IS NULL;

-- Specializations
SELECT specialization, COUNT(*) 
FROM SILVER.SRC_PROVIDERS
GROUP BY specialization 
ORDER BY COUNT(*) DESC;

-- Invalid NPIs
SELECT npi 
FROM SILVER.SRC_PROVIDERS
WHERE NOT REGEXP_LIKE(npi, '^\d{10}$');

-- =============================
-- 🏥 DEPARTMENTS VALIDATION
-- =============================

-- Duplicate dept_ids
SELECT dept_id, COUNT(*) 
FROM SILVER.SRC_DEPARTMENTS
GROUP BY dept_id
HAVING COUNT(*) > 1;

-- Null department names
SELECT * 
FROM SILVER.SRC_DEPARTMENTS
WHERE name IS NULL;

-- =============================
-- 💳 CPTCODES VALIDATION
-- =============================

-- Duplicates
SELECT cpt_codes, COUNT(*) 
FROM SILVER.SRC_CPTCODES
GROUP BY cpt_codes
HAVING COUNT(*) > 1;

-- Nulls
SELECT * 
FROM SILVER.SRC_CPTCODES
WHERE cpt_codes IS NULL OR procedure_code_descriptions IS NULL;

-- =============================
-- 💸 TRANSACTIONS & CLAIMS VALIDATION
-- =============================

-- Basic row samples
SELECT * FROM SILVER.SRC_TRANSACTIONS LIMIT 10;
SELECT * FROM SILVER.SRC_CLAIMS LIMIT 3;

-- Null fields
SELECT COUNT(*) AS total_claims,
       COUNT(claim_status) AS non_null_status,
       COUNT(claim_date) AS non_null_submission_date,
       COUNT(paid_amount) AS non_null_paid_amount
FROM SILVER.SRC_CLAIMS;

-- Distinct claim statuses
SELECT claim_status, COUNT(*) 
FROM SILVER.SRC_CLAIMS
GROUP BY claim_status;

-- Claims with null dates
SELECT * FROM SILVER.SRC_CLAIMS
WHERE claim_date IS NULL OR service_date IS NULL;

-- Paid claims
SELECT claim_status, COUNT(*)
FROM SILVER.SRC_CLAIMS
WHERE paid_amount > 0
GROUP BY claim_status;

-- Join check: Missing transactions
SELECT COUNT(*) 
FROM SILVER.SRC_CLAIMS c 
LEFT JOIN SILVER.SRC_TRANSACTIONS t 
  ON c.transaction_id = t.transaction_id 
WHERE t.transaction_id IS NULL;

-- Duplicate transaction IDs
SELECT transaction_id, COUNT(*) AS txn_count
FROM SILVER.SRC_TRANSACTIONS
GROUP BY transaction_id
HAVING COUNT(*) > 1
ORDER BY txn_count DESC;

