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
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (-2147483648, 'cus_be634c', '5', 'cus_e77be9', '2', 'cus_275a9f', 'cus_8c3f2a', 'cus_9a6a78', 'cus_d5f626', 'cus_c3359a', 'cus_eac53e', 'cus_58c31f');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (-2147483648, -2147483648, '2024-01-16 07:29:50+00:00', 'ord_0a08b4');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (1, 'lhs_3b8f29', 1, 1.0, 'lhs_471e7a', 'lhs_a2b2f4', 'lhs_c3a797');

INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (-2147483647, 'lhs_08df3f', 1, 1.0, 'lhs_ab5b95', 'lhs_686d81', 'lhs_6f50f9');

INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (-2147483646, 'lhs_3b8f29', -59984348, 0.0003, 'q_0_1d0f2c', 'pro_e0d808', 'pro_0105c6');

INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (-2147483645, 'lhs_08df3f', 1258409369, 0.0004, 'q_0_1d0f2c', 'pro_e0d808', 'pro_0105c6');

INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (2, 'lhs_3b8f29', -1726781632, 0.0005, 'pro_bf129f', 'pro_e0d808', 'pro_0105c6');

INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (3, 'lhs_3b8f29', 1610062532, 0.0006, 'pro_bf129f', 'pro_e0d808', 'pro_0105c6');

-- Inserting into table: product_categories --
INSERT INTO "product_categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('lhs_3b8f29', 'pro_da1588', 0.0001);

INSERT INTO "product_categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('lhs_08df3f', 'pro_da1588', 0.0002);

-- Inserting into table: order_items --
INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (4, -2147483648, 2, 'ord_f8c26a', 'ord_93f42c');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (5, -2147483648, 3, 'ord_f8c26a', 'ord_93f42c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT * FROM products AS LHS WHERE NOT EXISTS(SELECT 1 FROM order_items AS RHS WHERE (LHS.product_id = RHS.product_id))) ORDER BY product_name;

/*
Gold Result:
('lhs_471e7a',)
('lhs_ab5b95',)
('q_0_1d0f2c',)
('q_0_1d0f2c',)
*/

-- Prediction Query
SELECT product_name FROM Products EXCEPT SELECT T1.product_name FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id = T2.product_id;

/*
Prediction Result:
('lhs_471e7a',)
('lhs_ab5b95',)
('q_0_1d0f2c',)
*/