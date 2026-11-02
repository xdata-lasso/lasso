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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1025, 'serve', 'Nancy Gonzalez', '(415)595-1484x65648', 'yortega@example.net', '946 Kevin Fords
Floydmouth, NH 58406', 'letter', 'Republican');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1029, 'wear', 'Nancy Hopkins', '989-351-3433x2003', 'operry@example.net', '6320 Kimberly Forges Apt. 870
Port David, DC 61402', 'region', 'nice');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "shipping_method_code", "order_placed_datetime", "order_delivered_datetime", "order_shipping_charges") VALUES (1026, 1025, 'Cancelled', 'different', '1994-03-02', '1996-05-04', 'material');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "shipping_method_code", "order_placed_datetime", "order_delivered_datetime", "order_shipping_charges") VALUES (1027, 1025, 'Paid', 'much', '1994-03-03', '1996-05-05', 'student');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "shipping_method_code", "order_placed_datetime", "order_delivered_datetime", "order_shipping_charges") VALUES (1030, 1029, 'Cancelled', 'operation', '1998-07-06', '1971-09-08', 'free');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "shipping_method_code", "order_placed_datetime", "order_delivered_datetime", "order_shipping_charges") VALUES (1031, 1029, 'Paid', 'physical', '1998-07-07', '1971-09-09', 'someone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "order_shipping_charges", "customer_id" FROM "customer_orders" WHERE ("order_status_code" = 'Cancelled' OR "order_status_code" = 'Paid') ORDER BY order_shipping_charges, customer_orders.order_id NULLS LAST;

/*
Gold Result:
('free', 1029)
('material', 1025)
('someone', 1029)
('student', 1025)
*/

-- Prediction Query
SELECT order_shipping_charges, customer_id FROM customer_orders WHERE order_status_code = 'Cancelled' OR order_status_code = 'Paid';

/*
Prediction Result:
('material', 1025)
('student', 1025)
('free', 1029)
('someone', 1029)
*/