-- Schema DDL
CREATE TABLE "Premises" ("premise_id" INTEGER PRIMARY KEY, "premises_type" TEXT(15), "premise_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "product_name" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "customer_address" TEXT(255), "customer_login" TEXT(80), "customer_password" TEXT(10));

CREATE TABLE "Mailshot_Campaigns" ("mailshot_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "mailshot_name" TEXT(80), "mailshot_start_date" DATETIME, "mailshot_end_date" DATETIME);

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "premise_id" INTEGER, "date_address_from" DATETIME, "address_type_code" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("premise_id") REFERENCES "Premises" ("premise_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status_code" TEXT(15), "shipping_method_code" TEXT(15), "order_placed_datetime" DATETIME, "order_delivered_datetime" DATETIME, "order_shipping_charges" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Mailshot_Customers" ("mailshot_id" INTEGER, "customer_id" INTEGER, "outcome_code" TEXT(15), "mailshot_customer_date" DATETIME, FOREIGN KEY ("mailshot_id") REFERENCES "Mailshot_Campaigns" ("mailshot_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "item_id" INTEGER, "order_item_status_code" TEXT(15), "item_status_code" TEXT(15), "item_delivered_datetime" DATETIME, "item_order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (10, 'Credit Card', 'Eve Adams', '555-0201', 'eve@example.com', '505 Birch Ln', 'eve_a', 'secret1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (20, 'Cash', 'Frank Miller', '555-0202', 'frank@example.com', '606 Cedar Ct', 'frank_m', 'secret2');
INSERT INTO Products (product_id, product_category, product_name) VALUES (100, 'Books', 'Database Systems');
INSERT INTO Products (product_id, product_category, product_name) VALUES (200, 'Electronics', 'USB Cable');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (1, NULL, 'Paid', 'Standard', '2023-02-01 10:00:00', '2023-02-05 15:00:00', '12.50');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (2, 10, 'Cancelled', 'Express', '2023-02-02 11:00:00', NULL, NULL);
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (3, 10, NULL, 'Standard', '2023-02-03 12:00:00', NULL, '08.00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (4, 20, 'Paid', 'Overnight', '2023-02-04 13:00:00', '2023-02-05 09:00:00', '30.00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (5, 10, 'Cancelled', 'Standard', '2023-02-06 14:00:00', NULL, '05.00');
INSERT INTO Order_Items (order_id, product_id, item_id, order_item_status_code, item_status_code, item_delivered_datetime, item_order_quantity) VALUES (4, 100, 1, 'Delivered', 'Good', '2023-02-05 09:00:00', '1');
INSERT INTO Order_Items (order_id, product_id, item_id, order_item_status_code, item_status_code, item_delivered_datetime, item_order_quantity) VALUES (4, 200, 2, 'Delivered', 'Good', '2023-02-05 09:00:00', '3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "order_shipping_charges", "customer_id" FROM "customer_orders" WHERE ("order_status_code" = 'Cancelled' OR "order_status_code" = 'Paid') ORDER BY order_shipping_charges, customer_orders.order_id NULLS LAST;

/*
Gold Result:
(None, 10)
('05.00', 10)
('12.50', None)
('30.00', 20)
*/

-- Prediction Query
SELECT order_shipping_charges, customer_id FROM customer_orders WHERE order_status_code = 'Cancelled' OR order_status_code = 'Paid';

/*
Prediction Result:
('12.50', None)
(None, 10)
('30.00', 20)
('05.00', 10)
*/