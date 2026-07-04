select * from sales;
select count(*) as num_rows from sales;

select product, count(*) as num_sales
from sales
group by product;
order by num_sales desc;

-- change product name from laptop to Laptop
-- update sales 
-- set product = 'Laptop'
-- where product = 'laptop';
select product, count(*) as north_sales
from sales
where region = 'North'
group by product 
order by north_sales DESC;

select category,
	count(*) as total_sales,
	sum(amount) as total_revenue,
	round(avg(amount), 2) as avg_sale_amount
from sales
group by category;

-- Having Clause
select category, sum(amount) as total_revenue
from sales
group by category
having sum(amount) > 1000
order by total_revenue desc;


-- Query with all clauses 
select 
	product, 
	count(*) as sale_amount,
	sum(amount) as total_revenue
from sales
where region in ('North', 'South')
group by product
having count(*) >= 2
order by total_revenue asc
limit 3;


-- Practice Exercises

-- Count how many sales occurred in each region.
select region, count(*) as num_sales
from sales
group by region;

-- List each product and its average sale amount, but only for products with at least 2 sales.
select 
	product, 
	round(avg(amount), 2) as avg_amount 
from sales
group by product
having count(*) >=2;

-- Show categories that have total revenue between $100 and $2,000, sorted by total revenue ascending.
select 
	category, 
	sum(amount) as total_revenue 
from sales
group by category
having sum(amount) between 100 and 6000
order by total_revenue asc;

-- test query 
SELECT 
    category, 
    SUM(amount) AS total_revenue 
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

------------------------------------------------------------
SELECT category, SUM(amount) AS total_revenue
FROM sales
GROUP BY category
HAVING SUM(amount) BETWEEN 100 AND 2000
ORDER BY total_revenue ASC;

-- Find the top 5 products by total revenue for sales made in February 2025 
-- (hint: use sale_date >= '2025-02-01' AND sale_date < '2025-03-01'). Show product, total revenue, and number of sales.

select 
	product,
	sum(amount) as total_revenue,
	count(*) as num_sales
from sales
where sale_date >= '2025-02-01' AND sale_date < '2025-03-01'
group by product
order by total_revenue desc
limit 5;

