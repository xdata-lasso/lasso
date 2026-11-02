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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1005, 'claim', 'Rebecca Henderson', '366-697-8480', 'daniel62@example.com', '281 Skinner Parkways Apt. 252
New Mariotown, DE 48077', 'unit', 'theory');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1007, 'evidence', 'Lisa Brandt', '+1-534-565-7871', 'morganbrianna@example.org', '03105 Willie Harbors
Lewisberg, VA 75348', 'part', 'material');
INSERT INTO "premises" ("premise_id", "premises_type", "premise_details") VALUES (1006, 'surface', 'food');
INSERT INTO "premises" ("premise_id", "premises_type", "premise_details") VALUES (1008, 'eight', 'still');
INSERT INTO "customer_addresses" ("customer_id", "premise_id", "date_address_from", "address_type_code", "date_address_to") VALUES (1005, 1006, '1975-06-06', '62473 Scott Wall Apt. 080
Port Melindaburgh, MT 64154', '1976-07-07');
INSERT INTO "customer_addresses" ("customer_id", "premise_id", "date_address_from", "address_type_code", "date_address_to") VALUES (1007, 1008, '1977-08-08', '117 Tiffany Place
East Donna, OH 22144', '1978-09-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT address_type_code FROM customer_addresses ORDER BY address_type_code;

/*
Gold Result:
('117 Tiffany Place\nEast Donna, OH 22144',)
('62473 Scott Wall Apt. 080\nPort Melindaburgh, MT 64154',)
*/

-- Prediction Query
SELECT DISTINCT address_type_code FROM customer_addresses;

/*
Prediction Result:
('62473 Scott Wall Apt. 080\nPort Melindaburgh, MT 64154',)
('117 Tiffany Place\nEast Donna, OH 22144',)
*/