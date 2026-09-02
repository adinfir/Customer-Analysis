WITH max_date AS(
  SELECT
    MAX(created_at) as date_max
  FROM bigquery-public-data.thelook_ecommerce.order_items
)

,base AS (
  SELECT
    user_id,
    DATE_TRUNC(created_at, DAY) as sales_date,
    sale_price
  FROM bigquery-public-data.thelook_ecommerce.order_items
  WHERE status = 'Complete'
),
max_sd AS (
  SELECT
    user_id,
    MAX(sales_date) as max_sales_date
  FROM base
  GROUP BY user_id
),
RFM AS(
  SELECT
    a.user_id,
    DATE_DIFF(b.date_max, d.max_sales_date, DAY) AS recency,
    COUNT(DISTINCT c.order_id) as frequency,
    SUM(a.sale_price) AS monetary
  FROM base a
  CROSS JOIN max_date b
  JOIN bigquery-public-data.thelook_ecommerce.orders c
    USING(user_id)
  JOIN max_sd d
    USING(user_id)
  WHERE c.status = 'Complete'
  GROUP BY user_id, recency
)
SELECT *
FROM RFM
ORDER BY recency ASC