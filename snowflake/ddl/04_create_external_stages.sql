-- =============================
-- 📦 EXTERNAL STAGES
-- =============================

-- EMR data
CREATE OR REPLACE STAGE DBT_DB.EXTERNAL_STAGES.EMR_STAGE
    URL = 'azure://sanjanahealthcare.blob.core.windows.net/raw/emr/'
    STORAGE_INTEGRATION = snow_azure_int
    FILE_FORMAT = DBT_DB.FILE_FORMATS.CSV_FILEFORMAT;

-- Claims data
CREATE OR REPLACE STAGE DBT_DB.EXTERNAL_STAGES.CLAIMS_STAGE
    URL = 'azure://sanjanahealthcare.blob.core.windows.net/raw/claims/'
    STORAGE_INTEGRATION = snow_azure_int
    FILE_FORMAT = DBT_DB.FILE_FORMATS.CSV_FILEFORMAT;

-- CPT codes
CREATE OR REPLACE STAGE DBT_DB.EXTERNAL_STAGES.CPTCODES_STAGE
    URL = 'azure://sanjanahealthcare.blob.core.windows.net/raw/cptcodes/'
    STORAGE_INTEGRATION = snow_azure_int
    FILE_FORMAT = DBT_DB.FILE_FORMATS.CSV_FILEFORMAT;

-- =============================
-- 🔍 VALIDATION
-- =============================

-- Check integrations and metadata
SHOW STORAGE INTEGRATIONS;
SHOW FILE FORMATS IN SCHEMA DBT_DB.FILE_FORMATS;
SHOW STAGES IN SCHEMA DBT_DB.EXTERNAL_STAGES;

-- List files from EMR stage
LIST @DBT_DB.EXTERNAL_STAGES.EMR_STAGE;

