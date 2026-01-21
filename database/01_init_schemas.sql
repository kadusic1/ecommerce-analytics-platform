-- 1. Initialize Schemas
DROP SCHEMA IF EXISTS dwh CASCADE;
DROP SCHEMA IF EXISTS staging CASCADE;
DROP SCHEMA IF EXISTS source CASCADE;
DROP SCHEMA IF EXISTS logging CASCADE;

CREATE SCHEMA IF NOT EXISTS source;   -- Raw data landing zone
CREATE SCHEMA IF NOT EXISTS staging;  -- Transformation and cleaning zone
CREATE SCHEMA IF NOT EXISTS dwh;      -- Final Star Schema for reporting
CREATE SCHEMA IF NOT EXISTS logging;  -- ETL process logging
