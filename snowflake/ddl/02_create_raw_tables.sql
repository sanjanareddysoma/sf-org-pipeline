-- =====================================================
-- 02_create_raw_tables.sql
-- Purpose: Define all RAW tables for EMR and claims data
-- =====================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE DBT_DB;
USE SCHEMA RAW;

-- Drop if already exists (optional cleanup)
DROP TABLE IF EXISTS RAW_PATIENTS;
DROP TABLE IF EXISTS RAW_PROVIDERS;
DROP TABLE IF EXISTS RAW_DEPARTMENTS;
DROP TABLE IF EXISTS RAW_ENCOUNTERS;
DROP TABLE IF EXISTS RAW_TRANSACTIONS;
DROP TABLE IF EXISTS RAW_CLAIMS;

-- ----------------------------
-- RAW_PATIENTS
-- ----------------------------
CREATE OR REPLACE TABLE RAW_PATIENTS (
    PatientID VARCHAR PRIMARY KEY,
    FirstName VARCHAR,
    LastName VARCHAR,
    MiddleName VARCHAR,
    SSN VARCHAR,
    PhoneNumber VARCHAR,
    Gender VARCHAR,
    DOB DATE,
    Address VARCHAR,
    ModifiedDate DATE,
    HospitalID VARCHAR
);

-- ----------------------------
-- RAW_PROVIDERS
-- ----------------------------
CREATE OR REPLACE TABLE RAW_PROVIDERS (
    provider_id VARCHAR PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    specialization VARCHAR,
    dept_id VARCHAR,
    department_key VARCHAR,
    npi INTEGER
);

-- ----------------------------
-- RAW_DEPARTMENTS
-- ----------------------------
CREATE OR REPLACE TABLE RAW_DEPARTMENTS (
    department_id STRING,
    department_name STRING,
    hospital_id STRING,
    department_key STRING
);

-- ----------------------------
-- RAW_ENCOUNTERS
-- ----------------------------
CREATE OR REPLACE TABLE RAW_ENCOUNTERS (
    encounter_id VARCHAR,
    patient_id VARCHAR,
    patient_key VARCHAR,
    encounter_date DATE,
    encounter_type VARCHAR,
    provider_id VARCHAR,
    provider_key VARCHAR,
    dept_id VARCHAR,
    department_key VARCHAR,
    procedure_code VARCHAR,
    inserted_date DATE,
    modified_date DATE
);

-- ----------------------------
-- RAW_TRANSACTIONS
-- ----------------------------
CREATE OR REPLACE TABLE RAW_TRANSACTIONS (
    TransactionID VARCHAR PRIMARY KEY,
    EncounterID VARCHAR,
    PatientID VARCHAR,
    ProviderID VARCHAR,
    HospitalID VARCHAR,
    DepartmentID VARCHAR,
    VisitDate DATE,
    ServiceDate DATE,
    PaidDate DATE,
    VisitType VARCHAR,
    Amount DECIMAL,
    AmountType VARCHAR,
    PaidAmount DECIMAL,
    ClaimID VARCHAR,
    PayorID VARCHAR,
    ProcedureCode INTEGER,
    ICDCode VARCHAR,
    LineOfBusiness VARCHAR,
    MedicaidID VARCHAR,
    MedicareID VARCHAR,
    InsertDate DATE,
    ModifiedDate DATE
);

-- ----------------------------
-- RAW_CLAIMS
-- ----------------------------
CREATE OR REPLACE TABLE RAW_CLAIMS (
    claim_id VARCHAR PRIMARY KEY,
    transaction_id VARCHAR,
    patient_id VARCHAR,
    hospital_id VARCHAR,
    encounter_id VARCHAR,
    provider_id VARCHAR,
    dept_id VARCHAR,
    service_date DATE,
    claim_date DATE,
    payor_id VARCHAR,
    claim_amount NUMBER(38,2),
    paid_amount NUMBER(38,2),
    claim_status VARCHAR,
    payor_type VARCHAR,
    deductible NUMBER(38,2),
    coinsurance NUMBER(38,2),
    copay NUMBER(38,2),
    insert_date TIMESTAMP,
    modified_date TIMESTAMP
);


-- ----------------------------
-- CPTCODES: Reference table for procedure codes
-- ----------------------------
CREATE OR REPLACE TABLE CPTCODES (
    index VARCHAR PRIMARY KEY,
    Procedure_Code_Category VARCHAR,
    CPT_Codes VARCHAR,
    Procedure_Code_Descriptions VARCHAR,
    Code_Status VARCHAR
);
