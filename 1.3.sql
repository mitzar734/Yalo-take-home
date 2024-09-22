WITH RevenueData AS (
    SELECT 
        store_number, 
        store_name,
        ROUND(SUM(sale_dollars),2) AS total_revenue
    FROM 
        `bigquery-public-data.iowa_liquor_sales.sales`
    GROUP BY 
        store_number, store_name
),

TopStores AS (
    SELECT 
        store_number,
        store_name,
        total_revenue,
        'Top10' AS rank_
    FROM 
        RevenueData
    ORDER BY 
        total_revenue DESC
    LIMIT 10
),

BottomStores AS (
    SELECT 
        store_number,
        store_name,
        total_revenue,
        'Bottom 10' AS rank_
    FROM 
        RevenueData
    ORDER BY 
        total_revenue ASC
    LIMIT 10
)

SELECT * FROM TopStores
UNION ALL
SELECT * FROM BottomStores;