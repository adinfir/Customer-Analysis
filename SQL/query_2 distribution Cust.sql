--Distribution customer base on age, gender, country

--Making base for next analysis
WITH base AS (
  SELECT DISTINCT
    o.user_id,
    u.age,
    u.gender,
    u.country
  FROM bigquery-public-data.thelook_ecommerce.orders o
  JOIN bigquery-public-data.thelook_ecommerce.users u
    ON o.user_id = u.id
  WHERE o.status = 'Complete'
),

--make classification age and counting cust
classification_age AS (
  SELECT
    CASE
      WHEN age < 18 THEN "Teen"
      WHEN age BETWEEN 18 AND 26 THEN 'Gen Z'
      WHEN age BETWEEN 27 AND 42 THEN 'Millenial'
      WHEN age BETWEEN 43 AND 58 THEN 'Gen X'
      WHEN age BETWEEN 59 AND 75 THEN 'Boomer'
    END as segmentation,
    COUNT(user_id) as total_cust
  FROM base
  GROUP BY segmentation
),

--counting cust by gender
gender_cust AS (
  SELECT
    CASE
      WHEN gender = 'F' THEN 'Female'
      ELSE 'Male'
    END as gender,
    COUNT(user_id) as total_cust
  FROM base
  GROUP BY gender
),

--counting cust by country

country_cust AS(
  SELECT
    country,
    COUNT(user_id) as total_cust
  FROM base
  GROUP BY country
)

SELECT *
FROM classification_age;

SELECT *
FROM gender_cust;

SELECT * 
FROM country_cust;