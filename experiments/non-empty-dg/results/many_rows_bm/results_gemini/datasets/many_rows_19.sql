INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'Alice', 'USA', 'GOLD', 50000.0);
INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Electronics Cat', 'ELECTRONICS');
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-01-01', 'PAID', 100000.0);
