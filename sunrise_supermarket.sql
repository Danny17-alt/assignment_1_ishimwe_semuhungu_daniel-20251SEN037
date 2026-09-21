-- ============================================================
-- SUNRISE SUPERMARKET
-- Assignment I
-- Student: Ishimwe Semuhungu Daniel
-- Student ID: 20251SEN 037
-- DBMS: Oracle Database 26ai
-- ============================================================


-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100),
    email VARCHAR2(100),
    city VARCHAR2(50)
);

CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    price NUMBER(10,2)
);

CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES customers(customer_id),
    order_date DATE
);

CREATE TABLE order_items (
    order_item_id NUMBER PRIMARY KEY,
    order_id NUMBER REFERENCES orders(order_id),
    product_id NUMBER REFERENCES products(product_id),
    quantity NUMBER
);


-- ============================================================
-- 2. INSERT CUSTOMERS
-- ============================================================

INSERT INTO customers VALUES
(1, 'Alice Uwase', 'alice@example.com', 'Kigali');

INSERT INTO customers VALUES
(2, 'Brian Niyonzima', 'brian@example.com', 'Huye');

INSERT INTO customers VALUES
(3, 'Claudine Mukamana', 'claudine@example.com', 'Musanze');

INSERT INTO customers VALUES
(4, 'David Habimana', 'david@example.com', 'Rubavu');

INSERT INTO customers VALUES
(5, 'Emma Ingabire', 'emma@example.com', 'Kigali');

INSERT INTO customers VALUES
(6, 'Frank Tuyisenge', 'frank@example.com', 'Nyagatare');


-- ============================================================
-- 3. INSERT PRODUCTS
-- ============================================================

INSERT INTO products VALUES
(101, 'Milk 1L', 'Dairy', 1200.00);

INSERT INTO products VALUES
(102, 'Bread Loaf', 'Bakery', 1500.00);

INSERT INTO products VALUES
(103, 'Rice 2kg', 'Groceries', 3500.00);

INSERT INTO products VALUES
(104, 'Cooking Oil 1L', 'Groceries', 4200.00);

INSERT INTO products VALUES
(105, 'Cheese 500g', 'Dairy', 5500.00);

INSERT INTO products VALUES
(106, 'Biscuits Pack', 'Snacks', 1800.00);

INSERT INTO products VALUES
(107, 'Yogurt 500ml', 'Dairy', 2000.00);

INSERT INTO products VALUES
(108, 'Chocolate Bar', 'Snacks', 2500.00);


-- ============================================================
-- 4. INSERT ORDERS
-- ============================================================

INSERT INTO orders VALUES
(1001, 1, DATE '2026-09-01');

INSERT INTO orders VALUES
(1002, 2, DATE '2026-09-02');

INSERT INTO orders VALUES
(1003, 3, DATE '2026-09-03');

INSERT INTO orders VALUES
(1004, 1, DATE '2026-09-05');

INSERT INTO orders VALUES
(1005, 4, DATE '2026-09-06');

INSERT INTO orders VALUES
(1006, 5, DATE '2026-09-07');

INSERT INTO orders VALUES
(1007, 2, DATE '2026-09-09');

INSERT INTO orders VALUES
(1008, 3, DATE '2026-09-10');

INSERT INTO orders VALUES
(1009, 1, DATE '2026-09-12');

INSERT INTO orders VALUES
(1010, 4, DATE '2026-09-13');

INSERT INTO orders VALUES
(1011, 5, DATE '2026-09-15');

INSERT INTO orders VALUES
(1012, 2, DATE '2026-09-16');

INSERT INTO orders VALUES
(1013, 3, DATE '2026-09-18');

INSERT INTO orders VALUES
(1014, 4, DATE '2026-09-19');

INSERT INTO orders VALUES
(1015, 5, DATE '2026-09-20');


-- ============================================================
-- 5. INSERT ORDER ITEMS
-- ============================================================

INSERT INTO order_items VALUES (1, 1001, 101, 3);
INSERT INTO order_items VALUES (2, 1001, 102, 2);

INSERT INTO order_items VALUES (3, 1002, 103, 2);
INSERT INTO order_items VALUES (4, 1002, 106, 3);

INSERT INTO order_items VALUES (5, 1003, 104, 1);
INSERT INTO order_items VALUES (6, 1003, 107, 2);

INSERT INTO order_items VALUES (7, 1004, 105, 1);
INSERT INTO order_items VALUES (8, 1004, 108, 2);

INSERT INTO order_items VALUES (9, 1005, 102, 3);
INSERT INTO order_items VALUES (10, 1005, 103, 1);

INSERT INTO order_items VALUES (11, 1006, 101, 5);
INSERT INTO order_items VALUES (12, 1006, 107, 2);

INSERT INTO order_items VALUES (13, 1007, 104, 2);
INSERT INTO order_items VALUES (14, 1007, 106, 4);

INSERT INTO order_items VALUES (15, 1008, 105, 2);
INSERT INTO order_items VALUES (16, 1008, 108, 1);

INSERT INTO order_items VALUES (17, 1009, 103, 3);
INSERT INTO order_items VALUES (18, 1009, 104, 1);

INSERT INTO order_items VALUES (19, 1010, 101, 4);
INSERT INTO order_items VALUES (20, 1010, 102, 2);

INSERT INTO order_items VALUES (21, 1011, 106, 3);
INSERT INTO order_items VALUES (22, 1011, 108, 2);

INSERT INTO order_items VALUES (23, 1012, 105, 1);
INSERT INTO order_items VALUES (24, 1012, 107, 3);

INSERT INTO order_items VALUES (25, 1013, 103, 2);
INSERT INTO order_items VALUES (26, 1013, 104, 2);

INSERT INTO order_items VALUES (27, 1014, 101, 3);
INSERT INTO order_items VALUES (28, 1014, 106, 2);

INSERT INTO order_items VALUES (29, 1015, 102, 4);
INSERT INTO order_items VALUES (30, 1015, 108, 3);


-- ============================================================
-- 6. DATA VERIFICATION
-- ============================================================

SELECT 'Customers' AS table_name, COUNT(*) AS total_records
FROM customers
UNION ALL
SELECT 'Products', COUNT(*)
FROM products
UNION ALL
SELECT 'Orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*)
FROM order_items;


-- ============================================================
-- 7. REQUIRED JOIN QUERIES
-- ============================================================

-- 7.1 Every order with customer name, city, and date

SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_id;


-- 7.2 Every order item with product name, category, price, and quantity

SELECT
    oi.order_item_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;


-- 7.3 All customers and their orders, including customers with no orders

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;


-- ============================================================
-- 8. REQUIRED CTE
-- Customers whose total spending is above average
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        NVL(SUM(oi.quantity * p.price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;


-- ============================================================
-- 9. REQUIRED WINDOW FUNCTIONS
-- ============================================================

-- 9.1 Rank customers by total amount spent

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        NVL(SUM(oi.quantity * p.price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM customer_spending
ORDER BY spending_rank;


-- 9.2 Number each customer's orders in the order placed

SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    ROW_NUMBER() OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS order_number
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;


-- 9.3 Running total revenue over time

SELECT
    o.order_date,
    SUM(oi.quantity * p.price) AS daily_revenue,
    SUM(SUM(oi.quantity * p.price)) OVER (
        ORDER BY o.order_date
    ) AS running_total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;


-- 9.4 Days between current and previous order for each customer

SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    order_date - LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS days_since_previous_order
FROM (
    SELECT
        o.customer_id,
        c.customer_name,
        o.order_id,
        o.order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
)
ORDER BY customer_id, order_date;
