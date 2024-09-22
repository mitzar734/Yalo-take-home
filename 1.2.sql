SELECT 
  county,
  COUNT(county) AS times_over_100K
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
WHERE sale_dollars >100000
GROUP BY county
ORDER BY times_over_100K DESC