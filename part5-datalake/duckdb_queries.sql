-- Q1: List all customers along with the total number of orders they have placed
SELECT 
    c.name AS customer_name, 
    COUNT(o.order_id) AS total_orders
FROM 'customers.csv' c
LEFT JOIN 'orders.json' o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Q2: Find the top 3 customers by total order value
SELECT 
    c.name AS customer_name, 
    SUM(o.total_amount) AS total_order_value
FROM 'customers.csv' c
JOIN 'orders.json' o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT 
    p.product_name
FROM 'customers.csv' c
JOIN 'orders.json' o ON c.customer_id = o.customer_id
JOIN 'products.parquet' p ON o.product_id = p.product_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
SELECT 
    c.name AS customer_name, 
    o.order_date, 
    p.product_name, 
    o.num_items AS quantity
FROM 'customers.csv' c
JOIN 'orders.json' o ON c.customer_id = o.customer_id
JOIN 'products.parquet' p ON o.product_id = p.product_id;