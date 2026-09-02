# Customer Analysis

## 📌 Project Overview

This project analyzes **customer demographics, purchase behavior, and RFM-based customer segmentation** using the TheLook Ecommerce public dataset to understand customer base composition, purchasing patterns, and high-value customer segments.

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

The analysis identified **27,456 customers across 15 countries**, with gender distribution nearly balanced between **Female (50.4%)** and **Male (49.6%)**.

This indicates that the customer base does not have a significant gender concentration, allowing marketing strategies to be designed without relying heavily on gender-based targeting.

---

### 👨‍👩‍👧 Dominant Customer Age Segments

**Gen X (27.6%)** and **Millennials (26.6%)** were the two largest customer segments, together representing more than half of the total customer base.

This indicates that customers within these age groups represent an important target audience for customer engagement, retention, and promotional strategies

---

### 🌎 Customer Concentration by Country

**China (33.8%)** and the **United States (22.5%)** were the two largest customer markets.

Together with **Brazil, South Korea, and France**, these five countries accounted for approximately **81.2% of the total customer base**.

This concentration suggests that customer acquisition and retention strategies in these key markets could have a significant impact on overall customer performance.

---

### 🔄 Customer Retention Challenge

Approximately **88% of customers were one-time buyers**, while only **12% (3,422 customers)** had made multiple purchases.

This indicates a potential customer retention challenge, as the majority of customers did not return for another purchase.

Improving repeat purchase behavior could therefore provide a significant opportunity for increasing customer lifetime value.

---

### 💎 Top 10% High-Value Customers

The RFM Pareto analysis identified **2,756 customers in the top 10% spending segment**.

These customers had total spending ranging from approximately **$276 to $3,126**, with an average spending level of approximately **$514**.

This segment represents the highest-value portion of the customer base and can be prioritized for retention, loyalty, and personalized marketing initiatives.

---

### 🔁 Top 10% Customers Show Stronger Repeat Behavior

Within the top 10% spending segment, approximately **64% of customers were repeat buyers with a frequency of at least 2 transactions**.

This is substantially higher than the repeat-buyer proportion across the overall customer base.

The result suggests a strong relationship between **customer purchase frequency and monetary value**, making repeat purchase behavior an important factor in identifying high-value customers.

---

### 🏆 High-Frequency High-Value Customers

The analysis identified **295 customers with at least 3 completed transactions** within the top 10% monetary segment.

These customers generated an average spending level of approximately **$837**, significantly higher than the overall top-10% segment average of $514.

This group represents the strongest candidates for **VIP programs, loyalty rewards, personalized offers, and retention initiatives**.

---

### ⚠️ High-Value Customer at Risk

Customer **89173** was identified as the top spender, with approximately **$3,126 in total spending across 4 transactions**.

However, the customer had been inactive for approximately **451 days** based on the recency calculation.

Despite having high monetary value and multiple purchases, the long period since the last transaction indicates a potential **churn risk**.

This customer profile demonstrates why combining **Monetary, Frequency, and Recency** is more useful than evaluating customer value based on spending alone.*.

---

## 🧮 SQL Techniques Demonstrated

This project demonstrates practical SQL techniques commonly used in Data Analyst workflows.

### CTE

CTEs were used to organize customer purchase classification, demographic segmentation, and RFM calculation into logical analytical steps..

```sql
WITH base AS (
  SELECT
    user_id,
    COUNT(order_id) AS total_order
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  WHERE status = 'Complete'
  GROUP BY user_id
)
```

### CASE WHEN

```CASE WHEN``` was used to classify customers based on purchase behavior.

```sql
CASE
  WHEN total_order = 1 THEN 'one_time_buyer'
  WHEN total_order > 1 THEN 'multiple_buyer'
END AS classification
```

It was also used to classify customers into age generations.

```sql
CASE
  WHEN age < 18 THEN "Teen"
  WHEN age BETWEEN 18 AND 26 THEN 'Gen Z'
  WHEN age BETWEEN 27 AND 42 THEN 'Millenial'
  WHEN age BETWEEN 43 AND 58 THEN 'Gen X'
  WHEN age BETWEEN 59 AND 75 THEN 'Boomer'
END AS segmentation
```

### Aggregation

Aggregation functions were used to calculate customer counts, purchase frequency, and total spending.

```sql
COUNT(user_id) AS total_cust
```

```sql
COUNT(DISTINCT c.order_id) AS frequency
```

```sql
SUM(a.sale_price) AS monetary
```

### Date Functions
```DATE_TRUNC()``` was used to standardize transaction dates, while DATE_DIFF() was used to calculate customer recency.

```sql
DATE_DIFF(
  b.date_max,
  d.max_sales_date,
  DAY
) AS recency
```

### Window Function
```CUME_DIST()``` was used to calculate the cumulative distribution of customer monetary value and identify the top 10% highest-spending customers.

```sql
CUME_DIST() OVER (
  ORDER BY monetary ASC
) AS pct
```
Customers with a cumulative distribution above 90% were classified as the top 10% segment.

```sql
CASE
  WHEN pct > 0.90 THEN 'top_10_pct'
  ELSE 'regular'
END AS seg_pct
```

### RFM Analysis

RFM analysis was used to evaluate customers based on three dimensions:
- **Recency** = how recently the customer made a purchase
- **Frequency** = how many completed orders the customer made
- **Monetary** = how much the customer spent

```sql
DATE_DIFF(b.date_max, d.max_sales_date, DAY) AS recency,
COUNT(DISTINCT c.order_id) AS frequency,
SUM(a.sale_price) AS monetary
```

### CROSS JOIN

```CROSS JOIN``` was used to compare customer classifications against the overall customer population when calculating customer percentages

```sql
FROM flagging a
CROSS JOIN total_customer b
```

### JOIN

```JOIN```  was used to combine customer demographic information with completed order data.

```sql
FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON o.user_id = u.id
WHERE o.status = 'Complete'
```


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
│   └── dashboard.jpeg
└── Output/
    └── Output Query 1.jpeg
    └── Output Query 2.1.jpeg
    └── Output Query 2.2.jpeg
    └── Output Query 2.3.jpeg
    └── Output Query 3.jpeg
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

