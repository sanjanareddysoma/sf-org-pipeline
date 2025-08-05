# Healthcare Revenue Cycle Analytics Pipeline

A full-stack data engineering project demonstrating how to build a production-grade healthcare analytics pipeline using:  
**Azure Data Lake → Snowflake → dbt → Apache Airflow**

## 🚀 Project Objective

To build a scalable and modular data pipeline for healthcare Revenue Cycle Management (RCM) analytics — enabling KPIs like AR aging, claim denial rates, provider productivity, and department-wise billing trends across hospitals.

## 📂 About the Data

The dataset simulates Electronic Medical Records (EMR) and claims data from two hospitals. Each hospital has its own:
- `patients.csv`
- `providers.csv`
- `departments.csv`
- `transactions.csv`
- `encounters.csv`

Additionally, there's shared claims data and CPT code mappings. These are stored in Azure Data Lake, loaded into Snowflake, and transformed using dbt.  
Data has been normalized, standardized, and integrated across hospitals using hospital-specific keys to ensure multi-tenant analytics and referential integrity.

## 🧱 Architecture Overview

**Azure Data Lake → Snowflake (RAW → SILVER → GOLD) → dbt Transformations → Airflow Orchestration**
- Medallion Architecture  
- Multi-hospital integration  
- CI/CD + Airflow Orchestration

## 📈 Gold Layer KPIs

- `ar_balance_summary.sql`
- `claims_status_metrics.sql`
- `provider_performance_summary.sql`
- `department_revenue_summary.sql`
- `denials_by_dept_provider.sql`
- `procedure_statistics.sql`
- `patient_utilization_summary.sql`
- `missing_providers_audit.sql`

## 🧪 Getting Started

To replicate or build on this project:

### Clone the Repo
```bash
git clone https://github.com/sanjanareddysoma/sf-org-pipeline.git
cd sf-org-pipeline

Set Up Snowflake
Create roles, warehouses, and schemas using files in /snowflake/ddl/

Load raw data into ADLS and use external stages for loading into Snowflake

Configure dbt
Navigate to /dbt/healthcare/
Update your profiles.yml with Snowflake credentials
Run dbt models:
