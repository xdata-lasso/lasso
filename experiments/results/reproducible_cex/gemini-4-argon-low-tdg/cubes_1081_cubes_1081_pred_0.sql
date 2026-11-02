-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(50), "customer_middle_initial" TEXT(1), "customer_last_name" TEXT(50), "gender" TEXT(1), "email_address" TEXT(255), "login_name" TEXT(80), "login_password" TEXT(20), "phone_number" TEXT(255), "town_city" TEXT(50), "state_county_province" TEXT(50), "country" TEXT(50));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_order_placed" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_number" INTEGER PRIMARY KEY, "order_id" INTEGER, "invoice_date" DATETIME, FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"));

CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_account_opened" DATETIME, "account_name" TEXT(50), "other_account_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Product_Categories" ("production_type_code" TEXT(15) PRIMARY KEY, "product_type_description" TEXT(80), "vat_rating" REAL(19, 4));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "production_type_code" TEXT(15), "parent_product_id" INTEGER, "unit_price" REAL(19, 4), "product_name" TEXT(80), "product_color" TEXT(20), "product_size" TEXT(20), FOREIGN KEY ("production_type_code") REFERENCES "Product_Categories" ("production_type_code"));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "invoice_number" INTEGER, "transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL(19, 4), "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "order_id" INTEGER, "product_id" INTEGER, "product_quantity" TEXT(50), "other_order_item_details" TEXT(255), FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Invoice_Line_Items" ("product_id" INTEGER, "invoice_number" INTEGER, "order_item_id" INTEGER, "product_title" TEXT(80), "product_quantity" TEXT(50), "product_price" REAL(19, 4), "derived_product_cost" REAL(19, 4), "derived_vat_payable" REAL(19, 4), "derived_total_cost" REAL(19, 4), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"), FOREIGN KEY ("order_item_id") REFERENCES "Order_Items" ("order_item_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard execution, multiple orders (testing DISTINCT), multiple groupings by (other_order_item_details, product_id),
-- different counts per group, unreferenced products (testing INNER JOIN vs LEFT JOIN), and ORDER BY on both columns.
INSERT INTO Customers (customer_id, customer_first_name) VALUES (1, 'Alice');
INSERT INTO Product_Categories (production_type_code, product_type_description) VALUES ('CAT1', 'Category 1');
INSERT INTO Orders (order_id, customer_id, order_details) VALUES (10, 1, 'Order A');
INSERT INTO Orders (order_id, customer_id, order_details) VALUES (20, 1, 'Order B');
INSERT INTO Products (product_id, production_type_code, product_name) VALUES (100, 'CAT1', 'Zebra');
INSERT INTO Products (product_id, production_type_code, product_name) VALUES (200, 'CAT1', 'Apple');
INSERT INTO Products (product_id, production_type_code, product_name) VALUES (300, 'CAT1', 'Mango');
-- Product 200 ('Apple'): two groups of other_order_item_details with different counts (2 and 1), and another group with count 2 to test DISTINCT
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (1, 10, 200, '5', 'Detail_X');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (2, 20, 200, '3', 'Detail_X');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (3, 10, 200, '1', 'Detail_Y');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (4, 10, 200, '2', 'Detail_Z');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (5, 20, 200, '4', 'Detail_Z');
-- Product 100 ('Zebra'): one group with count 3
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (6, 10, 100, '1', 'Detail_X');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (7, 10, 100, '2', 'Detail_X');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (8, 20, 100, '1', 'Detail_X');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_name, n AS count___ FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, LHS.product_id AS product_id, LHS.parent_product_id AS parent_product_id, LHS.production_type_code AS production_type_code, LHS.unit_price AS unit_price, LHS.product_name AS product_name, LHS.product_color AS product_color, LHS.product_size AS product_size, RHS.other_order_item_details AS other_order_item_details, RHS.n AS n FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, RHS.product_id AS product_id, RHS.parent_product_id AS parent_product_id, RHS.production_type_code AS production_type_code, RHS.unit_price AS unit_price, RHS.product_name AS product_name, RHS.product_color AS product_color, RHS.product_size AS product_size FROM orders AS LHS CROSS JOIN products AS RHS) AS LHS INNER JOIN (SELECT other_order_item_details, product_id, COUNT(*) AS n FROM order_items GROUP BY other_order_item_details, product_id) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('Apple', 1)
('Apple', 2)
('Zebra', 3)
*/

-- Prediction Query
SELECT T2.product_name, COUNT(*) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id = T2.product_id JOIN Orders AS T3 ON T3.order_id = T1.order_id GROUP BY T2.product_name;

/*
Prediction Result:
('Apple', 5)
('Zebra', 3)
*/