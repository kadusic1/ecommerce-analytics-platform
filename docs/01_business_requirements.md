# Business Requirements Document
**E-Commerce BI Project** | January 20, 2026

---

## 1. Business Context

**Industry:** Online Retail - Home Décor & Gifts  
**Market:** UK (90%) + 37 International Countries  
**Data:** 541K transactions, 4.4K registered customers + 3.7K guest orders, 4K products (Dec 2010 - Dec 2011)

### Key Observations
- **Data volume:** 541,909 line items across 25,900 unique invoices
- **Guest checkouts:** 25% of transactions (no Customer ID)
- **Returns:** 3,836 return invoices (14.8% of orders) containing 9,288 returned line items (1.7% of total)
- **Sales vs Returns:** 22,064 sale invoices vs 3,836 return invoices
- **Bulk B2B orders:** Detected (80K+ units in single transactions)
- **High-value customer behavior:** Top customers show 15-27% return rates

---

## 2. Strategic Goals

1. **Maximize Revenue:** Identify high-value products and customer segments
2. **Improve Retention:** Reduce churn and increase repeat purchases
3. **Optimize Inventory:** Focus on profitable, fast-moving products
4. **Expand Markets:** Identify international growth opportunities
5. **Reduce Returns:** Flag quality issues and improve customer satisfaction

---

## 3. Key Performance Indicators (5 Priority KPIs)

### KPI 1: Monthly Net Revenue
**Formula:** `SUM(Quantity × Price) - ABS(SUM(Returns))`  
**Why:** Primary business health indicator  
**Target:** 5-10% month-over-month growth  
**Chart:** Line chart with trend

### KPI 2: Customer Retention Rate
**Formula:** `(Customers with 2+ Purchases ÷ Total Customers) × 100`  
**Why:** Retention is 5-7x cheaper than acquisition  
**Target:** >30% retention rate  
**Chart:** KPI card with historical comparison  
**Note:** Excludes guest checkouts

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
**Note:** Measured at invoice level (14.8% current), not line-item level (1.7%)

### KPI 5: Revenue by Country (Top 10 Non-UK)
**Formula:** `SUM(Revenue) GROUP BY Country WHERE Country != 'UK'`  
**Why:** Identify international expansion opportunities  
**Target:** 2+ countries with >£50K revenue  
**Chart:** Horizontal bar + geospatial map

---

**See Also:**
- `02_dwh_schema.md` - Data warehouse design (Star Schema)
- `03_elt_pipeline.md` - ETL pipeline technical guide

**DOCUMENT VERSION:** 1.0  
**LAST UPDATED:** January 20, 2026
