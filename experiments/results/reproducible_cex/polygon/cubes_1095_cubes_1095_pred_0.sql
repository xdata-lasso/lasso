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
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (21, '40', '40', '40', '40', '40', '40', '40', '40', '40', '40', '40');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (19, '40', '40', '40', '40', '40', '40', '40', '40', '40', '40', '40');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (20, NULL, 40, '40');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (40, 21, 32, NULL);
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (34, NULL, 38);
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (22, 40, 41);
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (40, 19, 40, '40', '40');
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('24', '40', 40);
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('23', '40', 40);
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (26, '24', 40, 40, '40', '40', '40');
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (25, '23', 40, 40, '40', '40', '40');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (27, 40, 25, '40', '40');
INSERT INTO "Invoice_Line_Items" ("product_id", "invoice_number", "order_item_id", "product_title", "product_quantity", "product_price", "derived_product_cost", "derived_vat_payable", "derived_total_cost") VALUES (25, 22, 27, '40', '40', 40, 40, 40, 40);
INSERT INTO "Invoice_Line_Items" ("product_id", "invoice_number", "order_item_id", "product_title", "product_quantity", "product_price", "derived_product_cost", "derived_vat_payable", "derived_total_cost") VALUES (26, 22, 27, '40', '40', 40, 40, 40, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_date, order_id, order_details FROM (SELECT LHS.invoice_number AS invoice_number, LHS.order_id AS order_id, LHS.invoice_date AS invoice_date, RHS.customer_id AS customer_id, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM invoices AS LHS LEFT JOIN orders AS RHS ON (LHS.order_id = RHS.order_id)) ORDER BY invoice_date, order_id NULLS LAST, order_details NULLS LAST;

/*
Gold Result:
(38, None, None)
(41, 40, None)
*/

-- Prediction Query
SELECT T1.invoice_date, T1.order_id, T2.order_details FROM Invoices AS T1 JOIN Orders AS T2 ON T1.order_id = T2.order_id;

/*
Prediction Result:
(41, 40, None)
*/