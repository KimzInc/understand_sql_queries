select count(*) from orders;

select count(*) from order_items;

select * from orders;

select * from order_items limit 4;

-- Glue two tables using join
select 
	o.order_id,
	o.customer_name,
	oi.product_name,
	oi.quantity,
	oi.unit_price
from orders o
join order_items oi on o.order_id = oi.order_id;

-- Calculate Total revenue per order
select 
	o.order_id,
	o.customer_name,
	sum(oi.quantity * oi.unit_price) as total_order_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id, o.customer_name
order by total_order_revenue desc;

-- Calculate the total revenue per customer 
select 
	o.customer_name,
	sum(oi.quantity * oi.unit_price) as total_customer_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.customer_name
order by total_customer_revenue desc;

-- Revenue per region with having 
select
	o.region,
	sum(oi.quantity * oi.unit_price) as total_region_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.region
having sum(oi.quantity * oi.unit_price) > 1000
order by total_region_revenue desc;

-- Monthly sales trends DATE_TRUNC('month', order_date)

-- DATE_TRUNC('month', order_date) turns a full date (like 2026-06-28) into 
-- the first day of that month (2026-06-01). This is perfect for grouping by month!

select 
	date_trunc('month', o.order_date) as sale_month,
	sum(oi.quantity * oi.unit_price) as monthly_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
group by sale_month
order by sale_month asc

-- Filter out cancelled orders
select 
 o.region,
 sum(oi.quantity * oi.unit_price) as revenue
from orders o
join order_items oi on o.order_id = oi.order_id
where o.status != 'Cancelled'
group by o.region
order by revenue desc;

-- Top products sold: we don't need orders table
select
  product_name,
  sum(quantity) as total_units_sold
from order_items
group by product_name
order by total_units_sold desc
limit 4;

-- For completed orders only, what is the total revenue per region 
-- for the month of June 2026, but show only regions that made over $500,
-- and sort them from best to worst?"

select
  o.region,
  sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id
where o.status = 'Completed'
    and o.order_date >= '2026-06-01'
	and o.order_date < '2026-07-01'
group by o.region
having sum(oi.quantity * oi.unit_price) > 500
order by total_revenue desc;


----------------------------------------------------------------------
SELECT 
    o.region,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed' 
  AND o.order_date >= '2026-06-01' 
  AND o.order_date < '2026-07-01'
GROUP BY o.region
HAVING SUM(oi.quantity * oi.unit_price) > 100
ORDER BY total_revenue DESC;
