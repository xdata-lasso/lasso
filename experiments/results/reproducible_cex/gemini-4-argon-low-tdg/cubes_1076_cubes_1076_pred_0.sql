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
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (1, 'Alice');
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description") VALUES ('CAT1', 'Electronics');
INSERT INTO "Products" ("product_id", "production_type_code", "product_name") VALUES (101, 'CAT1', 'Laptop');
INSERT INTO "Products" ("product_id", "production_type_code", "product_name") VALUES (102, 'CAT1', 'Mouse');
INSERT INTO "Products" ("product_id", "production_type_code", "product_name") VALUES (103, 'CAT1', 'Keyboard');
INSERT INTO "Orders" ("order_id", "customer_id", "order_details") VALUES (10, 1, 'Order 10');
INSERT INTO "Orders" ("order_id", "customer_id", "order_details") VALUES (20, 1, 'Order 20');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (1, 20, 101, 'Detail_A');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (2, 20, 101, 'Detail_A');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (3, 20, 102, 'Detail_A');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (4, 20, 103, 'Detail_B');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (5, 10, 101, 'Detail_A');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (6, 10, 102, 'Detail_A');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (7, 10, 103, 'Detail_A');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "other_order_item_details") VALUES (8, 10, 101, 'Detail_C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id, n_distinct AS count_distinct_product_id_ FROM (SELECT order_id, other_order_item_details, COUNT(DISTINCT product_id) AS n_distinct FROM order_items GROUP BY order_id, other_order_item_details) ORDER BY order_id, count_distinct_product_id_ NULLS LAST;

/*
Gold Result:
(10, 1)
(10, 3)
(20, 1)
(20, 2)
*/

-- Prediction Query
SELECT order_id, COUNT(DISTINCT product_id) FROM Order_items GROUP BY order_id;

/*
Prediction Result:
(10, 3)
(20, 3)
*/