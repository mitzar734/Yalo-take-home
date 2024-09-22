WITH validation_test_order_details AS (
    SELECT
        customer_id,
        purchase_timestamp AS purchase_date,
        ROUND(SUM(number_items * purchase_price), 2) AS purchase_revenue
    FROM test_order_details.csv
    WHERE
        item_status = 'sold'
    GROUP BY customer_id, purchase_date
)

SELECT
    to_.*,
	CASE
		WHEN to_.purchase_revenue != vtod.purchase_revenue THEN to_.purchase_revenue - vtod.purchase_revenue
	END AS variation_if_not_true
		
FROM
    test_orders.csv AS to_
JOIN
    validation_test_order_details AS vtod
ON
    to_.customer_id = vtod.customer_id 
AND
    to_.purchase_date = vtod.purchase_date
