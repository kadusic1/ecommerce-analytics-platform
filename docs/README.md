# BI Project: E-Commerce Analytics Platform
**University Project** | Business Intelligence

---

## Project Overview
**Industry:** Online Retail (Home Décor & Gifts)  
**Business Model:** B2B/Wholesale with some B2C (average basket: 258 items)  
**Data Volume:** 531K transactions | 8K customers | 4K products | 38 countries  
**Time Period:** December 2010 - December 2011  
**Tech Stack:** PostgreSQL 17.7 | n8n (ELT Orchestration) | Apache Superset (Visualization)

**Business Goal:** Transform raw CSV transactional data into a Star Schema data warehouse that powers executive dashboards for revenue optimization, customer retention, product performance, and international expansion strategy.

---

## System Architecture

```
Raw CSV (537K rows) → n8n ELT Pipeline (V8) → PostgreSQL Star Schema → Superset Dashboards (4)
```

**Database Schemas:**
- `source` - Raw CSV landing zone (TEXT columns, no transformations)
- `staging` - Cleaned/aggregated data with type casting and deduplication
- `dwh` - Star Schema (1 Fact Table + 4 Dimensions)
- `logging` - Audit trail for pipeline execution metrics

---

## Data Warehouse (Star Schema)

### Fact Table: `dwh.fact_sales` (531,225 rows)
**Grain:** Transaction line item (one row per product per invoice)

**Columns:** sales_key (PK), date_key (FK), customer_key (FK), product_key (FK), country_key (FK), invoice_no, transaction_type (SALE/RETURN), quantity, unit_price, line_total

### Dimensions

**`dim_customer` (8,082 rows)**  
Tracks registered customers and guest sessions.  
- Fields: customer_key (PK), customer_id (UNIQUE), customer_type, first_purchase_date
- Guest ID Format: `GST-{InvoiceNo}` (synthetic surrogate)

**`dim_product` (4,070 rows)**  
Products with keyword-based category assignment.  
- Fields: product_key (PK), stock_code (UNIQUE), description, category, product_type
- Category Source: `staging.product_category_lookup` (keyword matching)

**`dim_date` (1,096 rows)**  
Calendar dimension.  
- Fields: date_key (PK, YYYYMMDD format), full_date, day_of_week, month, month_name, quarter, year, is_weekend

**`dim_country` (38 rows)**  
API-enriched geographic data.  
- Fields: country_key (PK), original_name, country_name, continent, sub_region, iso_alpha2, iso_alpha3
- Data Source: RestCountries API (https://restcountries.com)

---

## ELT Pipeline (n8n V8)

**Orchestration:** n8n workflow with manual trigger  
**Batch Size:** 4,000 rows per database insert  
**Execution Flow:** 5 quality checkpoints with email notifications

### Pipeline Phases

**Phase 1: Extract & Load**  
CSV → `source.ecommerce_raw` (batched inserts, all TEXT columns)

**Phase 2: Transform**  
`source` → `staging.clean_sales` (aggregation, type casting, deduplication)  
- Aggregates duplicate InvoiceNo+StockCode combinations using GROUP BY
- Casts TEXT to INTEGER/NUMERIC/TIMESTAMP/DATE
- Identifies returns by 'C' prefix in InvoiceNo OR negative quantity

**Phase 3: Load DWH**  
`staging` → `dwh` (Star Schema with FK integrity)  
- Loads dimensions first (date → customer → product → country)
- Country dimension uses loop with API calls to RestCountries
- Fact table loaded last with surrogate key JOINs

**Phase 4: Validation**  
5 automated checkpoints enforce data quality:
- **Checkpoint #1:** File Check (count > 0)
- **Checkpoint #2:** Critical NULLs (InvoiceNo, StockCode, Date must exist)
- **Checkpoint #3:** Quality Funnel (measure data loss between source → staging)
- **Checkpoint #4:** Orphan Check (validate all FKs exist in dimensions)
- **Checkpoint #5:** Revenue Reconciliation (source vs DWH variance < 1%)

**Phase 5: Audit & Notify**  
Logs metrics to `logging.audit` table, sends success/failure email via Gmail

---

## Apache Superset Dashboards

**KPI vs Metric Distinction:**
- **KPIs (Key Performance Indicators):** Strategic measures linked to business goals, actionable, tracked regularly
- **Metrics:** Operational counts and descriptive statistics that support KPI analysis

### Dashboard 1: Executive Overview (ID: 14)
**Charts:** 8 visualizations
- Gross Sales (Big Number)
- Net Revenue (Big Number)
- Net Average Order Value (Big Number)
- Customer Retention Rate (Big Number)
- Net Monthly Revenue (Line Chart)
- Net Global Revenue Distribution (Pie Chart)
- Top International Markets by Net Revenue excl. UK (Bar Chart)
- Monthly Gross Sales vs Returns (Dual-Line Chart)

**KPIs:**
- Net Revenue - Primary business health indicator
- Net Average Order Value - Revenue efficiency per transaction
- Customer Retention Rate - Strategic customer loyalty measure

**Metrics:**
- Gross Sales - Supporting calculation for Net Revenue

**Audience:** C-suite, strategic decision-makers

### Dashboard 2: Sales Performance (ID: 15)
**Charts:** 10 visualizations
- Total Orders (Big Number)
- Basket Depth / Avg. Items per Order (Big Number)
- Unique Products Sold (Big Number)
- Return Rate (Big Number)
- Net Revenue by Category (Bar Chart)
- Top 20 Products by Net Revenue: Price vs Volume (Bubble Chart)
- Gross Sales Intensity by Month & Weekday (Heatmap)
- Top Products by Return Volume (Bar Chart)
- Order Value Distribution (Histogram)
- Top Selling Products by Volume (Bar Chart)

**KPIs:**
- Return Rate - Product quality and satisfaction indicator

**Metrics:**
- Total Orders - Operational count
- Basket Depth - Logistics efficiency metric
- Unique Products Sold - Inventory coverage count

**Audience:** Sales managers, inventory planners, operations

### Dashboard 3: Customer Analytics (ID: 18)
**Charts:** 9 visualizations
- Total Customers (Big Number)
- Customer Retention Rate (Big Number)
- Purchases Per Customer (Big Number)
- Customer Type Distribution (Pie Chart)
- Net Revenue Composition: Registered vs. Guest (Area Chart)
- Top Customers: Gross Sales vs. Returns (Bar Chart)
- Customer Loyalty Segmentation (Pie Chart)
- RFM Analysis (TOP 100): Recency & Net Revenue Distribution (Scatter Plot)
- VIP Product Affinity: Top 10 Items by Net Revenue (Bar Chart)

**KPIs:**
- Customer Retention Rate - Strategic loyalty measure (also on Dashboard 1)
- Purchases Per Customer - Customer lifetime value indicator

**Metrics:**
- Total Customers - Operational count

**Audience:** Marketing, CRM teams, customer success

### Dashboard 4: International Expansion (ID: 19)
**Charts:** 7 visualizations
- International Revenue (Big Number)
- Active Markets (Big Number)
- International Return Rate (Big Number)
- Global Reach excl. UK (Map Chart)
- International Category Preferences (Pie Chart)
- International Monthly Growth (Line Chart)
- Market Efficiency Matrix (Scatter Plot)

**KPIs:**
- International Revenue - Growth opportunity measure
- International Return Rate - Quality indicator for international markets

**Metrics:**
- Active Markets - Geographic reach count

**Audience:** Business development, expansion strategy, regional managers

---

## Strategic KPIs Framework (7 Core KPIs)

**We track dozens of metrics, but we manage the business by these 7 Core KPIs:**

### Primary Strategic KPIs (The CEO's View)
*These determine if the business survives.*

1. **Net Revenue** - The bottom line
   - *Dashboard: Executive Overview*
   - *Formula: Gross Sales - Returns*

2. **Net Average Order Value (AOV)** - The quality of each sale
   - *Dashboard: Executive Overview*
   - *Formula: Net Revenue / Total Orders*

3. **Customer Retention Rate** - The sustainability of the business
   - *Dashboard: Executive Overview & Customer Analytics*
   - *Formula: Repeat Customers / Total Customers*

### Operational Efficiency KPIs (The COO's View)
*These determine if the business runs smoothly.*

4. **Return Rate** - Direct measure of "Lost Revenue" and product failure
   - *Dashboard: Sales Performance*
   - *Formula: Returned Quantity / Total Sold Quantity*

5. **Basket Depth** - Direct measure of "Logistics Efficiency" and bulk-buying behavior
   - *Dashboard: Sales Performance*
   - *Formula: Total Items Sold / Total Orders*

### Growth & Expansion KPIs (The Head of Growth's View)
*These determine if the business has a future.*

6. **International Revenue** - Success outside the home market
   - *Dashboard: International Expansion*
   - *Formula: Sum(Revenue WHERE Country ≠ 'United Kingdom')*

7. **International Return Rate** - The "Risk Monitor" for expansion (it's currently a warning sign)
   - *Dashboard: International Expansion*
   - *Formula: International Returned Quantity / International Sold Quantity*
   - *Note: This is directly comparable to the overall Return Rate (KPI #4) since both use quantity-based calculation*
