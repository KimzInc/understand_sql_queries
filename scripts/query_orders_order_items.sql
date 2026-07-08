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


-- Filter out cancelled orders on specific region 
select 
	o.region,
	sum(oi.quantity * oi.unit_price) as revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
where o.status != 'Cancelled'
group by o.region 
order by revenue desc;

-- "Show me the total revenue per customer for only the North and East regions, 
-- for orders placed in July 2026, but only show customers who spent more than $1,000, 
-- and sort them alphabetically by name."

select 
    o.customer_name,
    sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
where o.order_date >= '2026-07-01'
    and (o.region = 'North' or o.region = 'East')
group by o.customer_name
having  sum(oi.quantity * oi.unit_price) > 1000
order by o.customer_name;

------ Alternative using 'in'

select 
    o.customer_name,
    sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
where o.order_date >= '2026-07-01'
    and o.region in ('North', 'East')
group by o.customer_name
having  sum(oi.quantity * oi.unit_price) > 1000
order by o.customer_name;

---- Cap the date
select 
    o.customer_name,
    sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
where o.order_date >= '2026-07-01'
	and o.order_date < '2026-08-1'
    and o.region in ('North', 'East')
group by o.customer_name
having  sum(oi.quantity * oi.unit_price) > 1000
order by o.customer_name;

-- Not in
select 
    o.customer_name,
    sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
where o.order_date >= '2026-07-01'
    and o.region not in ('North', 'East')
group by o.customer_name
having  sum(oi.quantity * oi.unit_price) > 1000
order by o.customer_name;


-- Monthly sales with Date trunc 
select 
	date_trunc('month', o.order_date) as sales_month,
	o.region,
	sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
group by sales_month,o.region 
order by sales_month asc;


select * from orders; 

-- Insert a new customer order with NO matching items in order_items
INSERT INTO orders (customer_name, order_date, region, status) 
VALUES ('Isabel Chen', '2026-07-08', 'North', 'Pending');

SELECT 
	o.order_id, 
	o.customer_name, 
	oi.product_name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;


-- Left join 
-- hint: "Show me all customers, regardless of whether they've placed an order yet."

select 
	o.order_id,
	o.customer_name,
	oi.product_name
from orders o
left join order_items oi on o.order_id = oi.order_id;


-- Right join
select 
	o.order_id,
	o.customer_name,
	oi.product_name
from orders o
right join order_items oi on o.order_id = oi.order_id;


-- Write a query that shows the Monthly Revenue per Region, 
-- but only for regions that generated more than $1,000 in total revenue for that specific month."

select
	date_trunc('month', o.order_date) as sales_date,
	o.region,
	sum(oi.quantity * oi.unit_price) as revenue
from orders o
join order_items oi on o.order_id = oi.order_id 
group by sales_date, o.region 
having sum(oi.quantity * oi.unit_price) > 1000
order by sales_date asc, revenue desc;


-- Show me the total revenue for every region, including regions that had zero sales (which should display as NULL or 0).
select 
	o.region,
	sum(oi.quantity * oi.unit_price) as total_revenue
from orders o
left join order_items oi on o.order_id = oi.order_id
group by o.region
order by total_revenue asc;


-- Correction of the above query
SELECT 
    o.region,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.region
ORDER BY total_revenue ASC;

---------------------------------------------------------

select 
	o.order_id,
	o.customer_name,
	o.region,
	oi.product_name,
	(oi.quantity * oi.unit_price) as revenue 
from orders o
left join order_items oi on o.order_id = oi.order_id;

-- Find regions with more than 3 orders.
select
	region,
	count(distinct order_id) 
from orders
group by region
having count(distinct order_id)  >= 3;

-- corrections

select 
	o.region,
	count(distinct o.order_id) as num_of_orders
from orders o
join order_items oi on o.order_id = oi.order_id 
group by o.region 
having count(distinct o.order_id) >=3
order by num_of_orders desc;


SELECT 
    o.region,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.region
HAVING COUNT(DISTINCT o.order_id) >1
ORDER BY number_of_orders DESC;

-- without distinct 	
SELECT 
    o.region,
    COUNT(*) AS item_count
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.region;


-- Find customers who have placed more than 1 order
select
	o.customer_name,
	count(distinct o.order_id) as number_of_orders
from orders o
join order_items oi on o.order_id = oi.order_id 
group by o.customer_name
having count(distinct o.order_id) > 1;

----------------------------------------------------------
-- Add a second order for Alice (she's our loyal customer!)
INSERT INTO orders (customer_name, order_date, region, status) 
VALUES ('Alice Johnson', '2026-07-11', 'North', 'Completed');


-- Add items to Alice's new order
INSERT INTO order_items (order_id, product_name, quantity, unit_price)
VALUES 
    ((SELECT MAX(order_id) FROM orders WHERE customer_name = 'Alice Johnson'), 'Monitor', 2, 350.00),
    ((SELECT MAX(order_id) FROM orders WHERE customer_name = 'Alice Johnson'), 'Keyboard', 1, 60.00);


-- test with the previous query 
select
	o.customer_name,
	count(distinct o.order_id) as number_of_orders
from orders o
join order_items oi on o.order_id = oi.order_id 
group by o.customer_name
having count(distinct o.order_id) > 1;


----------------------------------------------------------------------------------------------

----------------------- complex sub-queries ---------------

-- "Find customers who spent more than the average order value."

---- steps:

-- Calculate the average order value (total revenue per order, averaged across all orders).

-- Calculate each customer's total spending.

-- Compare each customer's spending to the average from step 1.

SELECT 
    o.customer_name,
    SUM(oi.quantity * oi.unit_price) AS customer_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > (
    -- Subquery: Calculate the average order value
    SELECT AVG(order_total) 
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS order_total
        FROM orders o2
        JOIN order_items oi2 ON o2.order_id = oi2.order_id
        GROUP BY o2.order_id
    ) AS avg_subquery
)
ORDER BY customer_total DESC;


--------------------------------------------------------------------------
select 
	o.customer_name,
	sum(oi.quantity * oi.unit_price) as customer_total
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.customer_name
having sum(oi.quantity * oi.unit_price) > (
	-- subquary: calculate the average order value
	select avg(order_total)
	from (
		select sum(oi2.quantity * oi2.unit_price) as order_total
		from orders o2
		join order_items oi2 on o2.order_id = oi2.order_id
		group by o2.order_id
	) as avg_subquery
	
	)
	order by customer_total desc;



