INSERT INTO customers (customer_id, customer_name, country, tier, credit_limit) VALUES (1, 'Alice', 'USA', 'GOLD', 1000.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) VALUES (1, 1, '2023-01-01', 'DELIVERED', 50.00);
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount) VALUES (2, 1, '2023-01-02', 'DELIVERED', 75.00);
INSERT INTO shipments (shipment_id, order_id, carrier, tracking_status, delivery_days) VALUES (1, 1, 'UPS', 'DELIVERED', 3);
INSERT INTO shipments (shipment_id, order_id, carrier, tracking_status, delivery_days) VALUES (2, 2, 'UPS', 'DELIVERED', 4);
