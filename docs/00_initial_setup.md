# Initial Setup
**One-Time Database Initialization** | January 22, 2026

This guide walks you through the complete database setup required before running your first ELT pipeline.

---

## Quick Start: Run All Setup Scripts

Execute the following scripts **in order** from the `database/` directory:

```bash
# Execute all setup scripts in sequence
psql "your_aiven_connection_string" -f database/01_init_schemas.sql
psql "your_aiven_connection_string" -f database/02_ddl_tables.sql
psql "your_aiven_connection_string" -f database/03_seed_data.sql
```

---

## What Each Script Does

### 1. `01_init_schemas.sql`
Creates the three-layer schema architecture:
- `source` — Raw data landing zone
- `staging` — Transformation and cleaning zone
- `dwh` — Final Star Schema for reporting

### 2. `02_ddl_tables.sql`
Defines all table structures across all schemas:
- **Source Layer:** `source.ecommerce_raw` (receives raw CSV)
- **Staging Layer:** `staging.product_category_lookup` (reference data)
- **DWH Layer:** Dimensions (`dim_date`, `dim_customer`, `dim_product`) and Fact table (`fact_sales`)

### 3. `03_seed_data.sql`
Populates the product category lookup table with 16 predefined keywords for product classification.

---

## Verification

After running all scripts, verify the setup:

```sql
-- Check schemas exist
SELECT schema_name FROM information_schema.schemata 
WHERE schema_name IN ('source', 'staging', 'dwh');

-- Verify all tables created
SELECT table_schema, table_name 
FROM information_schema.tables 
WHERE table_schema IN ('source', 'staging', 'dwh')
ORDER BY table_schema, table_name;

-- Confirm seed data loaded
SELECT COUNT(*) FROM staging.product_category_lookup;
-- Expected: 16 rows
```

---

## Clean Reset (Development Only)

If you need to completely reset the database during development:

```bash
psql "your_aiven_connection_string"-f database/00_teardown.sql
```

Then re-run the setup scripts above.
