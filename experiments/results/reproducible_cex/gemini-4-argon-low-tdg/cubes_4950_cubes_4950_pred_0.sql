-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard join vs natural join, DISTINCT vs ALL, and ASC vs DESC ordering.
-- Notice the query joins Products.product_id with Order_Items.order_id, NOT Order_Items.product_id.
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice', '2023-01-01 00:00:00', 'None');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1, 1, 'Shipped', '2023-01-02 00:00:00', 'Ord 1');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (2, 1, 'Pending', '2023-01-03 00:00:00', 'Ord 2');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (3, 1, 'Delivered', '2023-01-04 00:00:00', 'Ord 3');
INSERT INTO Products (product_id, product_details) VALUES (1, 'Zebra');
INSERT INTO Products (product_id, product_details) VALUES (2, 'Apple');
INSERT INTO Products (product_id, product_details) VALUES (10, 'Mango');
INSERT INTO Products (product_id, product_details) VALUES (20, 'Banana');
-- order_id=1 matches Products.product_id=1 ('Zebra') twice (tests duplicates / DISTINCT mutants)
-- product_id=10 and 20 would match 'Mango' and 'Banana' if a mutant joins on Products.product_id = Order_Items.product_id
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1, 10, '5');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1, 20, '2');
-- order_id=2 matches Products.product_id=2 ('Apple') once
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (2, 10, '1');
-- order_id=3 has no matching Products.product_id=3 (tests RIGHT JOIN / FULL OUTER JOIN mutants)
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (3, 20, '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_details FROM (SELECT product_id, product_details, product_id_other, order_quantity, n, product_id AS order_id FROM (SELECT LHS.product_id AS product_id, LHS.product_details AS product_details, RHS.product_id AS product_id_other, RHS.order_quantity AS order_quantity, RHS.n AS n FROM products AS LHS INNER JOIN (SELECT order_id, product_id, order_quantity, COUNT(*) OVER () AS n FROM order_items) AS RHS ON (LHS.product_id = RHS.order_id))) ORDER BY product_details;

/*
Gold Result:
('Apple',)
('Zebra',)
('Zebra',)
*/

-- Prediction Query
SELECT t2.product_details FROM order_items AS t1 JOIN products AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_id ORDER BY COUNT(*) DESC, t2.product_details NULLS LAST LIMIT 1;

/*
Prediction Result:
('Banana',)
*/