INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) 
VALUES (1, 'John Doe', 'USA', 'GOLD', 1000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) 
VALUES (1, 1, '2023-01-01', 'PAID', 700.00);
INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Gadgets', 'ELECTRONICS');
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity) 
VALUES 
(1, 1, 'Phone', 200.00, 10),
(2, 1, 'Tablet', 150.00, 10),
(3, 1, 'Headphones', 100.00, 10),
(4, 1, 'Charger', 50.00, 10);
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount) 
VALUES 
(1, 1, 1, 2, 200.00, 0.00),
(2, 1, 2, 1, 150.00, 0.00),
(3, 1, 3, 1, 100.00, 0.00),
(4, 1, 4, 1, 50.00, 0.00);
