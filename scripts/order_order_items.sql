-- Drop existing tables (if any) to start clean
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;

-- 1. Create the orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL,
    region VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Completed'
);

-- 2. Create the order_items table (child of orders)
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
    product_name VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL
);


-- 3. Insert data into orders (8 orders)
INSERT INTO orders (customer_name, order_date, region, status) VALUES
('Alice Johnson', '2026-06-28', 'North', 'Completed'),
('Bob Smith',     '2026-06-29', 'South', 'Completed'),
('Carol White',   '2026-06-30', 'East',  'Pending'),
('David Brown',   '2026-07-01', 'West',  'Completed'),
('Eva Martinez',  '2026-07-02', 'North', 'Completed'),
('Frank Lee',     '2026-07-03', 'South', 'Cancelled'),
('Grace Kim',     '2026-07-04', 'East',  'Completed'),
('Henry Wu',      '2026-07-05', 'West',  'Completed');

-- 4. Insert data into order_items (multiple items per order)
INSERT INTO order_items (order_id, product_name, quantity, unit_price) VALUES
-- Order 1 (Alice, North)
(1, 'Laptop',    1, 1200.00),
(1, 'Mouse',     2, 25.00),
(1, 'USB Cable', 3, 10.00),

-- Order 2 (Bob, South)
(2, 'Monitor',   2, 320.00),
(2, 'Keyboard',  1, 45.00),

-- Order 3 (Carol, East) – Pending
(3, 'Desk',      1, 250.00),
(3, 'Chair',     2, 150.00),

-- Order 4 (David, West)
(4, 'Tablet',    3, 450.00),
(4, 'Stylus',    3, 30.00),

-- Order 5 (Eva, North)
(5, 'Phone',     2, 800.00),
(5, 'Screen Protector', 4, 15.00),
(5, 'Charger',   2, 20.00),

-- Order 6 (Frank, South) – Cancelled
(6, 'Sofa',      1, 600.00),
(6, 'Ottoman',   1, 200.00),

-- Order 7 (Grace, East)
(7, 'Notebook', 10, 5.00),
(7, 'Pen',       5, 2.00),

-- Order 8 (Henry, West)
(8, 'Monitor',   1, 310.00),
(8, 'Laptop',    1, 1150.00),
(8, 'Mouse',     1, 28.00);
