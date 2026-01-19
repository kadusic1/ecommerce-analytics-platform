# Business Requirements Document
**E-Commerce BI Project** | January 19, 2026

---

## 1. Business Context

**Industry:** Online Retail - Home Décor & Gifts  
**Market:** UK (90%) + 37 International Countries  
**Data:** 541K transactions, 4.4K customers, 4K products (Dec 2010 - Dec 2011)

### Key Observations
- 25% transactions are guest checkouts (no Customer ID)
- 1.7% return rate (Invoice IDs prefixed with "C")
- Bulk B2B orders detected (80K+ units in single transactions)
- Top customers show 15-27% return rates

---

## 2. Strategic Goals

1. **Maximize Revenue:** Identify high-value products and customer segments
2. **Improve Retention:** Reduce churn and increase repeat purchases
3. **Optimize Inventory:** Focus on profitable, fast-moving products
4. **Expand Markets:** Identify international growth opportunities
5. **Reduce Returns:** Flag quality issues and improve customer satisfaction

---

## 3. Key Performance Indicators (5 Priority KPIs)

### KPI 1: Monthly Gross Revenue
**Formula:** `SUM(Quantity × Price) - ABS(SUM(Returns))`  
**Why:** Primary business health indicator  
**Target:** 5-10% month-over-month growth  
**Chart:** Line chart with trend

### KPI 2: Customer Retention Rate
**Formula:** `(Customers with 2+ Purchases ÷ Total Customers) × 100`  
**Why:** Retention is 5-7x cheaper than acquisition  
**Target:** >30% retention rate  
**Chart:** KPI card with historical comparison

### KPI 3: Top 20 Products by Revenue
**Formula:** `SUM(Quantity × Price) GROUP BY Product`  
**Why:** Focus inventory and marketing on winners  
**Target:** Top 20 = 40%+ of total revenue (Pareto)  
**Chart:** Horizontal bar chart

### KPI 4: Return/Cancellation Rate
**Formula:** `(Return Invoices ÷ Total Invoices) × 100`  
**Why:** Quality and expectation issues  
**Target:** <5% return rate  
**Chart:** Monthly trend line

### KPI 5: Revenue by Country (Top 10 Non-UK)
**Formula:** `SUM(Revenue) GROUP BY Country WHERE Country != 'UK'`  
**Why:** Identify international expansion opportunities  
**Target:** 2+ countries with >£50K revenue  
**Chart:** Horizontal bar + geospatial map

---

## 4. Data Warehouse Design (Star Schema)

**Fact Table:** `fact_sales`
- Grain: Transaction line level
- Measures: `quantity`, `unit_price`, `line_total`
- Foreign Keys: `date_key`, `customer_key`, `product_key`

**Dimensions:**
- `dim_date`: Date hierarchy (day → month → quarter → year)
- `dim_customer`: `customer_id`, `country`, `first_purchase_date`
- `dim_product`: `stock_code`, `description`, `category`

**Aggregate Tables (for performance):**
- `agg_monthly_revenue`: Pre-calculated monthly KPIs
- `agg_product_performance`: Product-level metrics

---

## 5. Implementation Phases

| Phase | Deliverable |
|-------|-------------|
| 1. Data Foundation | Star Schema + ETL pipeline |
| 2. KPI Development | Calculate 5 KPIs in `dwh` schema |
| 3. Dashboards | Superset visualizations |
| 4. Deployment | UAT + Training |

---

## 6. Success Criteria

**Technical:**
- [ ] ETL runs daily with <1% error rate
- [ ] Dashboard loads in <3 seconds

**Business:**
- [ ] All 5 KPIs visible and accurate
- [ ] 100% stakeholder training within 2 weeks

**Data Quality:**
- [ ] <0.1% nulls in dimension keys
- [ ] 100% referential integrity

---

**END OF DOCUMENT**
