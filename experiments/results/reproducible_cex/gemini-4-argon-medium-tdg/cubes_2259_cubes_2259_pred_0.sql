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
-- DATASET 1
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'Alice');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (2, 'Bob');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (3, 'Charlie');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (4, 'Diana');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_shipping_charges") VALUES (10, 1, 'Cancelled', '50.00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_shipping_charges") VALUES (20, 2, 'Paid', '10.00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_shipping_charges") VALUES (30, 3, 'Pending', '5.00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_shipping_charges") VALUES (40, 4, NULL, '20.00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "order_shipping_charges", "customer_id" FROM "customer_orders" WHERE ("order_status_code" = 'Cancelled' OR "order_status_code" = 'Paid') ORDER BY order_shipping_charges, customer_orders.order_id NULLS LAST;

/*
Gold Result:
('10.00', 2)
('50.00', 1)
*/

-- Prediction Query
SELECT order_shipping_charges, customer_id FROM customer_orders WHERE order_status_code = 'Cancelled' OR order_status_code = 'Paid';

/*
Prediction Result:
('50.00', 1)
('10.00', 2)
*/