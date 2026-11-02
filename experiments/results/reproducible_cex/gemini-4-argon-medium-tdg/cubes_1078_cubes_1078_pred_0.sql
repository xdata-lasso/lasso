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
-- Tests standard anti-join, ordering, duplicate product_names across unordered products, and NULL values in Order_Items.product_id (which breaks NOT IN mutants).
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('CAT1', 'Electronics', 0.20);
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (1, 'John', 'Doe');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed") VALUES (10, 1, '2023-01-01 10:00:00');
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (1, 'CAT1', NULL, 100.00, 'Zebra Phone', 'Black', 'Medium');
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (2, 'CAT1', 1, 50.00, 'Alpha Case', 'Red', 'Small');
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (3, 'CAT1', 1, 60.00, 'Alpha Case', 'Blue', 'Large');
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (4, 'CAT1', 5, 200.00, 'Beta Tablet', 'Silver', 'Large');
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (5, 'CAT1', NULL, 300.00, 'Gamma Laptop', 'Grey', '15 inch');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity") VALUES (100, 10, 1, '1');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity") VALUES (101, 10, 1, '2');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity") VALUES (102, 10, 5, '1');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity") VALUES (103, 10, NULL, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT * FROM products AS LHS WHERE NOT EXISTS(SELECT 1 FROM order_items AS RHS WHERE (LHS.product_id = RHS.product_id))) ORDER BY product_name;

/*
Gold Result:
('Alpha Case',)
('Alpha Case',)
('Beta Tablet',)
*/

-- Prediction Query
SELECT product_name FROM Products EXCEPT SELECT T1.product_name FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id = T2.product_id;

/*
Prediction Result:
('Alpha Case',)
('Beta Tablet',)
*/