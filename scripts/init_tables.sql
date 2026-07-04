-- Create a new database (adjust name if you like)
CREATE DATABASE practice_db;

-- Connect to it (in psql: \c practice_db; in pgAdmin: select the database)
\c practice_db;

-- Drop the table if it already exists (for clean re-runs)
DROP TABLE IF EXISTS sales;

-- Create the sales table
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    product VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    sale_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL
);

-- Insert sample data (20 rows)
INSERT INTO sales (product, category, region, sale_date, amount) VALUES
('Laptop', 'Electronics', 'North', '2025-01-10', 1200.00),
('Laptop', 'Electronics', 'South', '2025-01-12', 1150.00),
('Tablet', 'Electronics', 'North', '2025-01-15', 450.00),
('Tablet', 'Electronics', 'East', '2025-01-18', 480.00),
('Phone', 'Electronics', 'West', '2025-01-20', 800.00),
('Phone', 'Electronics', 'South', '2025-01-22', 780.00),
('Desk', 'Furniture', 'North', '2025-01-25', 250.00),
('Desk', 'Furniture', 'East', '2025-01-28', 270.00),
('Chair', 'Furniture', 'North', '2025-02-01', 150.00),
('Chair', 'Furniture', 'West', '2025-02-03', 140.00),
('Sofa', 'Furniture', 'South', '2025-02-05', 600.00),
('Sofa', 'Furniture', 'East', '2025-02-07', 650.00),
('Notebook', 'Stationery', 'North', '2025-02-10', 5.00),
('Notebook', 'Stationery', 'South', '2025-02-12', 4.50),
('Pen', 'Stationery', 'East', '2025-02-14', 2.00),
('Pen', 'Stationery', 'West', '2025-02-16', 2.50),
('Pencil', 'Stationery', 'North', '2025-02-18', 1.50),
('Pencil', 'Stationery', 'South', '2025-02-20', 1.20),
('Monitor', 'Electronics', 'East', '2025-02-22', 300.00),
('Monitor', 'Electronics', 'West', '2025-02-25', 320.00);
