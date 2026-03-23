-- Q1: Total sales revenue by product category for each month
SELECT 
    d.year, 
    d.month, 
    p.category, 
    SUM(f.total_sales) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.year, d.month, p.category
ORDER BY d.year, d.month, p.category;


-- Q2: Top 2 performing stores by total revenue
SELECT 
    s.store_name, 
    SUM(f.total_sales) AS total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_revenue DESC
LIMIT 2;


-- Q3: Month-over-month sales trend across all stores
SELECT 
    current_month.year, 
    current_month.month, 
    current_month.revenue AS current_month_revenue,
    previous_month.revenue AS previous_month_revenue,
    (current_month.revenue - previous_month.revenue) AS mom_revenue_change
FROM (
    SELECT d.year, d.month, SUM(f.total_sales) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_id = d.date_id
    GROUP BY d.year, d.month
) current_month
LEFT JOIN (
    SELECT d.year, d.month, SUM(f.total_sales) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_id = d.date_id
    GROUP BY d.year, d.month
) previous_month 
ON current_month.year = previous_month.year 
AND current_month.month = previous_month.month + 1
ORDER BY current_month.year, current_month.month;