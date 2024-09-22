SELECT
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(QUARTER FROM date) AS quarter,
  SUM(bottles_sold) AS total_bottles_sold,
  ROUND(SUM(sale_dollars), 2) AS total_sale_dollars

FROM
  `bigquery-public-data.iowa_liquor_sales.sales`
GROUP BY
  year,quarter
ORDER BY
  year, quarter