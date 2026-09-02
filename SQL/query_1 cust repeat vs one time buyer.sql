--pct cust repeat purchase vs one time buyer
WITH base AS (
  SELECT
    user_id,
    COUNT(order_id) total_order
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE status = 'Complete'
  GROUP BY user_id
),
flagging AS (
  SELECT
    CASE
      WHEN total_order = 1 THEN 'one_time_buyer'
      WHEN total_order > 1 THEN 'multiple_buyer'
    END as classification,
    COUNT(user_id) as total_cust
  FROM base
  GROUP BY classification
),
total_customer AS (
  SELECT
    COUNT(user_id) as total_cust
  FROM base
)

SELECT
  a.classification,
  a.total_cust,
  ROUND(a.total_cust / b.total_cust,2) as pct
FROM flagging a
CROSS JOIN total_customer b

