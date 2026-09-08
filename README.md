# Customer Analysis

## 📌 Project Overview

This project analyzes **customer demographics, purchase behavior, and RFM-based customer segmentation over a 24-month period (January 2024 – December 2025)** using the TheLook Ecommerce public dataset to understand customer base composition, purchasing patterns, and high-value customer segments.

The analysis focuses on identifying **customer demographic distributions, one-time vs. repeat buyers, and high-value customers based on monetary spending** to support customer retention, targeting, and loyalty strategies.

The analysis was conducted using **Google BigQuery (GoogleSQL)** with CTEs, conditional aggregation, window functions, date functions, and customer-level segmentation.

---

## 🗂️ Dataset

The analysis uses the **TheLook Ecommerce** public dataset in Google BigQuery.

The analysis combines data from three tables:

- `users` — customer demographic and geographic information
- `orders` — order-level transaction and purchase behavior information
- `order_items` — item-level transaction and spending information

### Key Columns

#### `users`

| Column | Description |
|---|---|
| `id` | Unique customer identifier |
| `first_name` | Customer first name |
| `last_name` | Customer last name |
| `email` | Customer email address |
| `age` | Customer age |
| `gender` | Customer gender |
| `state` | Customer state |
| `street_address` | Customer street address |
| `postal_code` | Customer postal code |
| `city` | Customer city |
| `country` | Customer country |
| `latitude` | Customer geographic latitude |
| `longitude` | Customer geographic longitude |
| `traffic_source` | Source through which the customer reached the platform |
| `created_at` | Timestamp when the customer record was created |
| `user_geom` | Geographic information associated with the customer |

#### `orders`

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `user_id` | Unique customer identifier |
| `status` | Current status of the order |
| `gender` | Customer gender associated with the order |
| `created_at` | Timestamp when the order was created |
| `returned_at` | Timestamp when the order was returned |
| `shipped_at` | Timestamp when the order was shipped |
| `delivered_at` | Timestamp when the order was delivered |
| `num_of_item` | Number of items included in the order |

#### `order_items`

| Column | Description |
|---|---|
| `id` | Unique order item identifier |
| `order_id` | Identifier linking the order item to an order |
| `user_id` | Unique customer identifier |
| `product_id` | Identifier linking the order item to a product |
| `inventory_item_id` | Identifier linking the order item to an inventory item |
| `status` | Current status of the order item |
| `created_at` | Timestamp when the order item was created |
| `shipped_at` | Timestamp when the item was shipped |
| `delivered_at` | Timestamp when the item was delivered |
| `returned_at` | Timestamp when the item was returned |
| `sale_price` | Selling price of the product in the transaction |

### Columns Primarily Used in the Analysis

The analysis primarily uses the following columns from the three source tables:

#### `users`

- `id` — joins customer demographic information with transaction data
- `age` — classifies customers into generational segments
- `gender` — analyzes customer distribution by gender
- `country` — analyzes customer distribution by country

#### `orders`

- `order_id` — calculates the number of unique orders and customer purchase frequency
- `user_id` — identifies customers and connects orders with customer information
- `status` — filters completed orders
- `created_at` — provides order transaction timing when required for purchase analysis

#### `order_items`

- `order_id` — connects order items with customer orders
- `user_id` — identifies customers for RFM analysis
- `status` — filters completed order items
- `created_at` — determines the most recent customer purchase for Recency
- `sale_price` — calculates customer total spending for the Monetary component of RFM

---

## 🔗 Data Relationship

The three tables are connected through customer and order identifiers:

```text
users
  │
  │ id = user_id
  ▼
orders
  │
  │ order_id
  ▼
order_items
```
This relationship allows order-level metrics to be combined with item-level sales and product attributes.

---

## 🛠️ Tools & Technologies

- **Google BigQuery**
- **GoogleSQL**
- CTEs (`WITH`)
- Date Functions
- `DATE_DIFF()`
- `DATE_TRUNC()`
- Window Functions
- `CUM_DIST()`
- `COUNT(DISTINCT)`
- `SUM()`
- `COUNT()`
- 'ROUND()`
- `CASE WHEN`
- `GROUP BY`
- `CROSS JOIN`
- Multi - Level Agregation
- Conditional Segmentation
- RFM Analysis


---

## 📊 Key Metrics

### Total Customers

Number of customers with completed orders included in the analysis.

### One-Time Buyer

Customers who have completed exactly one order.

### Multiple Buyer

Customers who have completed more than one order.

### Customer Demographic Distribution

Distribution of customers based on age generation, gender, and country.

### Recency

Number of days since a customer's most recent completed purchase.

### Frequency

Number of unique completed orders associated with a customer.

### Monetary

Total spending generated by a customer based on completed order items.

### Top 10% Customer Segment

Customers whose cumulative monetary distribution places them in the top 10% based on total spending.

---

## 📈 Insight

### 👥 Customer Base Distribution

A total of **11,825 customers** were identified across **15 countries** during the 2024–2025 analysis period.

The gender distribution was relatively balanced, with **Female customers accounting for 51.2%** and **Male customers 48.8%**.

This indicates that the customer base is broadly balanced by gender, suggesting that customer acquisition and retention strategies do not need to rely heavily on a single gender segment.

---

### 🎯 Dominant Age Segments

**Gen X (27.4%)** and **Millennial (25.9%)** were the two largest customer segments, together representing more than half of the customer base.

These segments should be considered important audiences for **targeted campaigns, personalized offers, and retention initiatives**, particularly when combined with their purchase frequency and spending behavior.

---

### 🌍 Customer Concentration Across Markets

**China (33.9%)** and the **United States (22.8%)** were the two largest customer markets.

Together with **Brazil, South Korea, and France**, these five countries accounted for **81.4% of the total customer base**.

This concentration suggests that customer activity is heavily concentrated in a relatively small number of markets, making these countries important priorities for **localized marketing, customer retention, and market-specific strategies**.

---

### ⚠️ High One-Time Buyer Rate

Customer retention represents a major challenge.

**93.78% of customers made only one purchase**, while just **6.22% (735 customers)** made multiple purchases during 2024–2025.

The very low repeat-purchase rate indicates that the business has a substantial opportunity to improve **customer retention, repeat purchase behavior, and post-purchase engagement**.

Potential strategies include:

* Personalized follow-up campaigns
* Repeat-purchase incentives
* Loyalty programs
* Cross-selling and product recommendations
* Targeted reactivation campaigns

---

### 💰 Top 10% Customers Drive a Significant Share of Revenue

RFM-based Pareto analysis identified **1,192 customers in the top 10% by monetary value**.

Their spending ranged from **$239 to $2,321**, with an average spend of **$432**.

Despite representing only 10% of the customer base, this segment contributed approximately **38.4% of total revenue**, equivalent to around **$515K of the $1.34M analyzed revenue**.

This concentration highlights the importance of protecting and retaining high-value customers because their behavior has a disproportionate impact on overall revenue.

---

### 🔁 Top 10% Customers Show Stronger Repeat Behavior

Within the top 10% spending segment, **56.3% were repeat buyers (frequency ≥ 2)**.

This is substantially higher than the overall repeat-purchase rate of **6.22%**.

The finding suggests that customers who generate higher spending are also more likely to purchase repeatedly, making this group a strong priority for **retention and loyalty programs**.

---

### ⭐ High-Value Repeat Customers

A subset of **130 customers with frequency ≥ 3** generated an average spend of **$613**.

These customers combine relatively high spending with repeated purchase behavior, making them strong candidates for:

* VIP customer programs
* Loyalty rewards
* Personalized promotions
* Early access to products
* High-value customer engagement campaigns

This segment represents a smaller but particularly valuable group within the broader top-spending customer base.

---

### 🚨 High-Value Customer at Churn Risk

Customer **41696** was the highest spender, generating **$2,321 across 3 transactions**.

However, the customer has been inactive for **672 days**.

The combination of **high historical monetary value, multiple transactions, and prolonged inactivity** indicates a potentially high-value customer at significant churn risk.

This type of customer should be prioritized for **reactivation campaigns and personalized retention efforts** rather than treated the same as inactive low-value customers.


---

## 🧮 SQL Techniques Demonstrated

### 1. CTE (Common Table Expression)

Used multiple CTEs to break complex customer analysis into logical stages, such as customer aggregation, classification, RFM calculation, and percentile segmentation.

```sql
WITH base AS (...),
flagging AS (...),
total_customer AS (...)
```

### 2. Date Filtering with `FORMAT_DATE()`

Restricted the analysis to the **2024–2025** period using year-based filtering on `created_at`.

```sql
WHERE FORMAT_DATE('%Y', created_at) IN ('2024', '2025')
```

### 3. `CASE WHEN` for Customer Segmentation

Used conditional logic to classify customers into purchase behavior and demographic segments.

```sql
CASE
  WHEN total_order = 1 THEN 'one_time_buyer'
  WHEN total_order > 1 THEN 'multiple_buyer'
END
```

Age segmentation was also created using multiple conditions:

```sql
CASE
  WHEN age BETWEEN 27 AND 42 THEN 'Millennial'
  WHEN age BETWEEN 43 AND 58 THEN 'Gen X'
END
```

### 4. Aggregation & `GROUP BY`

Used `COUNT()`, `COUNT(DISTINCT)`, `SUM()`, `AVG()`, and `GROUP BY` to calculate customer counts, purchase frequency, and monetary value.

```sql
COUNT(DISTINCT c.order_id) AS frequency,
SUM(a.sale_price) AS monetary
```

### 5. `JOIN` & `CROSS JOIN`

Joined customer, order, and transaction-level data to combine demographic and purchasing information.

```sql
JOIN bigquery-public-data.thelook_ecommerce.users u
  ON o.user_id = u.id
```

A `CROSS JOIN` was used to apply the maximum analysis date to each customer's RFM calculation.

```sql
CROSS JOIN max_date b
```

### 6. Window Function — `CUME_DIST()`

Used `CUME_DIST()` to calculate each customer's cumulative distribution based on monetary value and identify the top 10% highest-spending customers.

```sql
CUME_DIST() OVER(ORDER BY monetary ASC) AS pct
```

### 7. Ratio & Percentage Calculation

Calculated the proportion of one-time and multiple buyers relative to the total customer base.

```sql
ROUND(a.total_cust / b.total_cust * 100, 2) AS pct
```

The same approach was used to translate the cumulative distribution into a percentage-based customer segment.

### 8. RFM Calculation

Combined **Recency, Frequency, and Monetary** metrics to evaluate customer value:

* **Recency:** days since the customer's most recent purchase
* **Frequency:** number of distinct completed orders
* **Monetary:** total spending based on `sale_price`

```sql
DATE_DIFF(b.date_max, d.max_sales_date, DAY) AS recency,
COUNT(DISTINCT c.order_id) AS frequency,
SUM(a.sale_price) AS monetary
```

### 9. Conditional Aggregation

Used conditional counting to classify and summarize customer purchase behavior.

```sql
COUNTIF(...)
```

and multiple aggregation stages were used to produce customer-level distributions.

---

## 📁 Project Structure

```text
Customer-Analysis/
│
├── README.md
│
├── sql/
│   └── query_1 cust repeat vs one time buyer.sql
│   └── query_2 distribution Cust.sql
│   └── query_3 RFM.sql
│
├── images/
│   ├── Preview Table order_items the_look ecommerce.jpeg
│   ├── Preview Table orders the_look ecommerce.jpeg
│   └── Preview Table users the_look ecommerce.jpeg
│
└── dashboard/
│   └── dashboard.png
└── Output/
    └── Output Query 1.png
    └── Output Query 2.1.png
    └── Output Query 2.2.png
    └── Output Query 2.3.png
    └── Output Query 3.png
```

> The project uses the public TheLook Ecommerce dataset available through Google BigQuery. No private customer transaction data is included in this repository.

---

## 🚀 Future Analysis

This analysis can be extended with additional customer and marketing analytics such as:

* Customer Cohort Analysis
* Customer Retention Analysis
* Customer Lifetime Value (CLV)
* RFM Score Segmentation
* Customer Churn Analysis
* Repeat Purchase Rate
* Purchase Frequency Analysis
* Customer Revenue Contribution
* Country-Level Customer Performance
* Generational Customer Behavior
* Customer Purchase Journey Analysis
* Customer Reactivation Analysis
* Personalized Customer Targeting

These additional analyses would provide a deeper understanding of **customer behavior, retention opportunities, and high-value customer growth strategies**.

---

## 👤 Author

[Curriculum Vitae](https://drive.google.com/file/d/1Sf1mfTCJu-IcL2qFh0gElmXqYrTEsl3b/view?usp=sharing) | [Portfolio](https://public.tableau.com/app/profile/adin4572/vizzes)

**Adient Fir**

Data Analyst Portfolio Project

**Focus:** SQL | Customer Analytics | RFM Analysis | BigQuery

