-- Database Teardown Script
-- WARNING: This script will DROP all tables and schemas.
-- Use ONLY in development environments for clean resets.

-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS dwh.fact_sales CASCADE;
DROP TABLE IF EXISTS dwh.dim_product CASCADE;
DROP TABLE IF EXISTS dwh.dim_customer CASCADE;
DROP TABLE IF EXISTS dwh.dim_date CASCADE;

DROP TABLE IF EXISTS staging.product_category_lookup CASCADE;
DROP TABLE IF EXISTS source.ecommerce_raw CASCADE;

-- Drop schemas
DROP SCHEMA IF EXISTS dwh CASCADE;
DROP SCHEMA IF EXISTS staging CASCADE;
DROP SCHEMA IF EXISTS source CASCADE;
