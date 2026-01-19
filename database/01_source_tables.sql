-- Defines the landing zone for n8n
DROP TABLE IF EXISTS source.ecommerce_raw;

CREATE TABLE source.ecommerce_raw (
    InvoiceNo   TEXT,
    StockCode   TEXT,
    Description TEXT,
    Quantity    TEXT,
    InvoiceDate TEXT,
    UnitPrice   TEXT,
    CustomerID  TEXT,
    Country     TEXT
);
