DROP TABLE IF EXISTS dwh.fact_sales CASCADE;
DROP TABLE IF EXISTS dwh.dim_product CASCADE;
DROP TABLE IF EXISTS dwh.dim_customer CASCADE;
DROP TABLE IF EXISTS dwh.dim_date CASCADE;
DROP TABLE IF EXISTS staging.product_category_lookup CASCADE;
DROP TABLE IF EXISTS source.ecommerce_raw CASCADE;
DROP TABLE IF EXISTS logging.audit CASCADE;
DROP TABLE IF EXISTS dwh.dim_country CASCADE;

-- 2.1 Source Layer (Raw CSV Storage)
CREATE TABLE IF NOT EXISTS source.ecommerce_raw (
    invoiceno TEXT,
    stockcode TEXT,
    description TEXT,
    quantity TEXT,
    invoicedate TEXT,
    unitprice TEXT,
    customerid TEXT,
    country TEXT,
    UNIQUE (invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country)
);

-- 2.2 Staging Layer (Lookup Tables)
CREATE TABLE IF NOT EXISTS staging.product_category_lookup (
    keyword VARCHAR(50) PRIMARY KEY,
    category VARCHAR(100) NOT NULL,
    priority INTEGER NOT NULL
);

-- 2.3 DWH Layer (Dimensions)
CREATE TABLE IF NOT EXISTS dwh.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE,
    day_of_week VARCHAR(10),
    day_of_month INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    quarter INTEGER,
    year INTEGER,
    is_weekend BOOLEAN
);

CREATE UNIQUE INDEX idx_dim_date_full ON dwh.dim_date(full_date);
CREATE INDEX idx_dim_date_year_month ON dwh.dim_date(year, month);

CREATE TABLE IF NOT EXISTS dwh.dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(50) UNIQUE,
    customer_type VARCHAR(20),
    first_purchase_date DATE
);

CREATE UNIQUE INDEX idx_dim_customer_id ON dwh.dim_customer(customer_id) 
    WHERE customer_id IS NOT NULL;
CREATE INDEX idx_dim_customer_type ON dwh.dim_customer(customer_type);

CREATE TABLE IF NOT EXISTS dwh.dim_product (
    product_key SERIAL PRIMARY KEY,
    stock_code VARCHAR(50) UNIQUE,
    description TEXT,
    category VARCHAR(100)
);

CREATE UNIQUE INDEX idx_dim_product_code ON dwh.dim_product(stock_code);
CREATE INDEX idx_dim_product_category ON dwh.dim_product(category);

CREATE TABLE IF NOT EXISTS dwh.dim_country (
    country_key SERIAL PRIMARY KEY,
    original_name VARCHAR(100) UNIQUE,
    country_name VARCHAR(100) UNIQUE,
    continent VARCHAR(50),
    sub_region VARCHAR(50),
    iso_alpha2 CHAR(2),
    iso_alpha3 CHAR(3)
);
CREATE UNIQUE INDEX idx_dim_country_original ON dwh.dim_country(original_name);
CREATE UNIQUE INDEX idx_dim_country_name ON dwh.dim_country(country_name);

-- 2.4 DWH Layer (Facts)
CREATE TABLE IF NOT EXISTS dwh.fact_sales (
    sales_key SERIAL PRIMARY KEY,
    date_key INTEGER REFERENCES dwh.dim_date(date_key),
    customer_key INTEGER REFERENCES dwh.dim_customer(customer_key),
    product_key INTEGER REFERENCES dwh.dim_product(product_key),
    invoice_no VARCHAR(50),
    transaction_type VARCHAR(10),
    quantity INTEGER,
    unit_price NUMERIC(10,2),
    line_total NUMERIC(10,2),
    country_key INTEGER REFERENCES dwh.dim_country(country_key),
    CONSTRAINT unique_invoice_item UNIQUE (invoice_no, product_key)
);

CREATE INDEX idx_fact_sales_date ON dwh.fact_sales(date_key);
CREATE INDEX idx_fact_sales_customer ON dwh.fact_sales(customer_key);
CREATE INDEX idx_fact_sales_product ON dwh.fact_sales(product_key);
CREATE INDEX idx_fact_sales_type ON dwh.fact_sales(transaction_type);
CREATE INDEX idx_fact_sales_country ON dwh.fact_sales(country_key);
CREATE INDEX idx_dim_date_full_date ON dwh.dim_date(full_date);

CREATE TABLE IF NOT EXISTS logging.audit (
    log_id SERIAL PRIMARY KEY,
    run_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    raw_row_count INT, -- Verify Load Count Node
    funnel_gap INT,  -- Quality Funnel Node
    orphan_count INT, -- Orphan Check Node
    revenue_variance_pct NUMERIC(5,2) -- Revenue Variance Node
);
