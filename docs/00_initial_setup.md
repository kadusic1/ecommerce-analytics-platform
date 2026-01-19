# Initial Setup
**One-Time Database Initialization** | January 22, 2026

**Run these scripts once during project initialization before the first ELT execution.**

**Prerequisites:** Ensure schemas exist by running `database/00_init_schemas.sql` first.

---

## 1. Create Error Logging Table

**Purpose:** Capture type casting and transformation errors during ELT runs.

```sql
CREATE TABLE IF NOT EXISTS staging.etl_errors (
    error_id SERIAL PRIMARY KEY,
    error_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    error_phase VARCHAR(50),
    error_message TEXT,
    row_data JSONB
);
```

**Tool:** PostgreSQL Execute Query (run manually or via n8n setup workflow)

---

## 2. Create Product Category Lookup Table

**Purpose:** Reference data for categorizing products in `dwh.dim_product`.

```sql
CREATE TABLE IF NOT EXISTS staging.product_category_lookup (
    keyword VARCHAR(50) PRIMARY KEY,
    category VARCHAR(100) NOT NULL,
    priority INTEGER NOT NULL
);

INSERT INTO staging.product_category_lookup (keyword, category, priority)
VALUES
    ('MUG', 'Kitchenware', 1),
    ('CUP', 'Kitchenware', 1),
    ('PLATE', 'Kitchenware', 1),
    ('TEAPOT', 'Kitchenware', 1),
    ('HEART', 'Décor', 2),
    ('CANDLE', 'Décor', 2),
    ('FRAME', 'Décor', 2),
    ('LANTERN', 'Décor', 2),
    ('CHRISTMAS', 'Seasonal', 3),
    ('HALLOWEEN', 'Seasonal', 3),
    ('BAG', 'Accessories', 4),
    ('PURSE', 'Accessories', 4),
    ('NOTEBOOK', 'Stationery', 5),
    ('CARD', 'Stationery', 5),
    ('TOY', 'Toys & Games', 6),
    ('GAME', 'Toys & Games', 6)
ON CONFLICT (keyword) DO NOTHING;
```

**Maintenance:** Add new keywords by running additional INSERT statements as needed.

---

## 3. Verification

**Check that tables were created successfully:**

```sql
-- Verify etl_errors table
SELECT COUNT(*) FROM staging.etl_errors;
-- Expected: 0 (empty, ready for logging)

-- Verify category lookup table
SELECT COUNT(*) FROM staging.product_category_lookup;
-- Expected: 16 (all keywords loaded)
```

---

**DOCUMENT VERSION:** 1.0  
**LAST UPDATED:** January 22, 2026  
**RELATED:** [03_elt_pipeline.md](./03_elt_pipeline.md) | [02_dwh_schema.md](./02_dwh_schema.md)
