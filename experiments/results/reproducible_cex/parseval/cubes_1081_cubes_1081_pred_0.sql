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
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1, 'cus_be634c', '5', 'cus_e77be9', '2', 'cus_275a9f', 'cus_8c3f2a', 'cus_9a6a78', 'cus_d5f626', 'cus_c3359a', 'cus_eac53e', 'cus_58c31f');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'lhs_d05d36');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (1, 'rhs_3b1213', 1, 1.0, 'rhs_792cff', 'rhs_f18d00', 'rhs_edab94');

-- Inserting into table: product_categories --
INSERT INTO "product_categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('rhs_3b1213', 'pro_da1588', 0.0001);

-- Inserting into table: order_items --
INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483648, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483647, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483646, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483645, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483644, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483643, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483642, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483641, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483640, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483639, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483638, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483637, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483636, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483635, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483634, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483633, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483632, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483631, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483630, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483629, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483628, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483627, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483626, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483625, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483624, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483623, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483622, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483621, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483620, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483619, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483618, 1, 1, 'ord_f8c26a', NULL);

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483617, 1, 1, 'ord_f8c26a', NULL);

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483616, 1, 1, 'ord_f8c26a', NULL);

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483615, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483614, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483613, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483612, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483611, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483610, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483609, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483608, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483607, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483606, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483605, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483604, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483603, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483602, 1, 1, 'ord_f8c26a', 'ord_3637b6');

INSERT INTO "order_items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (-2147483601, 1, 1, 'ord_f8c26a', 'ord_3637b6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_name, n AS count___ FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, LHS.product_id AS product_id, LHS.parent_product_id AS parent_product_id, LHS.production_type_code AS production_type_code, LHS.unit_price AS unit_price, LHS.product_name AS product_name, LHS.product_color AS product_color, LHS.product_size AS product_size, RHS.other_order_item_details AS other_order_item_details, RHS.n AS n FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, RHS.product_id AS product_id, RHS.parent_product_id AS parent_product_id, RHS.production_type_code AS production_type_code, RHS.unit_price AS unit_price, RHS.product_name AS product_name, RHS.product_color AS product_color, RHS.product_size AS product_size FROM orders AS LHS CROSS JOIN products AS RHS) AS LHS INNER JOIN (SELECT other_order_item_details, product_id, COUNT(*) AS n FROM order_items GROUP BY other_order_item_details, product_id) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('rhs_792cff', 3)
('rhs_792cff', 45)
*/

-- Prediction Query
SELECT T2.product_name, COUNT(*) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id = T2.product_id JOIN Orders AS T3 ON T3.order_id = T1.order_id GROUP BY T2.product_name;

/*
Prediction Result:
('rhs_792cff', 48)
*/