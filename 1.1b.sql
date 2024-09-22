WITH monthly_sales AS (
  SELECT
    EXTRACT(YEAR FROM date) AS year,
    FORMAT_TIMESTAMP('%B', date) AS month,
    SUM(bottles_sold) AS total_bottles_sold,
    ROUND(SUM(sale_dollars), 2) AS total_sale_dollars
  FROM
    `bigquery-public-data.iowa_liquor_sales.sales`
  GROUP BY
    year, month
),

average_monthly_revenue AS (
  SELECT
    ROUND(AVG(total_sale_dollars), 2) AS avg_monthly_revenue
  FROM
    monthly_sales
)

SELECT
  ms.year,
  ms.month,
  ms.total_bottles_sold,
  ms.total_sale_dollars,
  amr.avg_monthly_revenue,
  CASE
    WHEN ms.total_sale_dollars > amr.avg_monthly_revenue * 1.10 THEN 'Above 10% Average'
    ELSE 'Below 10% Average'
  END AS performance
FROM
  monthly_sales ms
CROSS JOIN
  average_monthly_revenue amr

WHERE 
  CASE
    WHEN ms.total_sale_dollars > amr.avg_monthly_revenue * 1.10 THEN 'Above 10% Average'
    ELSE 'Below 10% Average'
  END = 'Above 10% Average'
ORDER BY
 ms.year, ms.month
