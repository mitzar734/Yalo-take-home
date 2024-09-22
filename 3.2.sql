WITH tmp_test_order_details AS (
    SELECT
        customer_id,
        SUM(CASE WHEN item_status = 'sold' THEN number_items ELSE 0 END) AS vol_sold,
        SUM(CASE WHEN item_status = 'returned' THEN number_items ELSE 0 END) AS vol_returned,
        ROUND(SUM(CASE WHEN item_status = 'sold' THEN number_items * purchase_price ELSE 0 END), 2) AS purchase_revenue,
        ROUND(SUM(number_items * purchase_price), 2) AS purchase_revenue_with_no_returns
    FROM
        test_order_details.csv
    GROUP BY
        customer_id
)
SELECT
    tmptod.*,
    ROUND(((SUM(tmptod.purchase_revenue_with_no_returns) - SUM(tmptod.purchase_revenue)) / SUM(tmptod.purchase_revenue))*100,2) AS increase_percentage
FROM
    tmp_test_order_details AS tmptod
GROUP BY
    tmptod.customer_id,
    tmptod.vol_sold,
    tmptod.vol_returned,
    tmptod.purchase_revenue,
    tmptod.purchase_revenue_with_no_returns
ORDER BY
    increase_percentage DESC;
