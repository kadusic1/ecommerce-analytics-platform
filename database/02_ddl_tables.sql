DROP TABLE IF EXISTS dwh.fact_sales CASCADE;
DROP TABLE IF EXISTS dwh.dim_product CASCADE;
DROP TABLE IF EXISTS dwh.dim_customer CASCADE;
DROP TABLE IF EXISTS dwh.dim_date CASCADE;
DROP TABLE IF EXISTS staging.product_category_lookup CASCADE;
DROP TABLE IF EXISTS source.ecommerce_raw CASCADE;

-- 2.1 Source Layer (Raw CSV Storage)
CREATE TABLE IF NOT EXISTS source.ecommerce_raw (
    invoiceno TEXT,
    stockcode TEXT,
    description TEXT,
    quantity TEXT,
    invoicedate TEXT,
    unitprice TEXT,
    customerid TEXT,
    country TEXT
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

CREATE TABLE IF NOT EXISTS dwh.dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(50) UNIQUE,
    customer_type VARCHAR(20),
    first_purchase_date DATE
);

CREATE TABLE IF NOT EXISTS dwh.dim_product (
    product_key SERIAL PRIMARY KEY,
    stock_code VARCHAR(50) UNIQUE,
    description TEXT,
    category VARCHAR(100)
);

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
    country VARCHAR(100),
    CONSTRAINT unique_invoice_item UNIQUE (invoice_no, product_key)
);