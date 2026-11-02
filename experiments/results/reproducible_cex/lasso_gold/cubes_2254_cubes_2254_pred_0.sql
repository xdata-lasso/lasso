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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1014, 'coach', 'Joshua Turner', '+1-680-584-1241x1824', 'james48@example.com', '64005 Dana Greens
Lake Scott, VT 56558', 'option', 'act');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1018, 'pick', 'Nicholas Edwards', '+1-581-769-3406x088', 'qjones@example.com', '484 Nguyen Square
Angelaborough, MT 87654', 'yard', 'hundred');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1016, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "premises" ("premise_id", "premises_type", "premise_details") VALUES (1015, 'brother', 'bag');
INSERT INTO "premises" ("premise_id", "premises_type", "premise_details") VALUES (1019, 'research', 'smile');
INSERT INTO "customer_addresses" ("customer_id", "premise_id", "date_address_from", "address_type_code", "date_address_to") VALUES (1014, 1015, '1980-11-11', 'USNS Gardner
FPO AA 76851', '1981-01-12');
INSERT INTO "customer_addresses" ("customer_id", "premise_id", "date_address_from", "address_type_code", "date_address_to") VALUES (1016, 1015, '1982-02-13', '5868 Crosby Crescent
Gregoryview, AZ 14709', '1983-03-14');
INSERT INTO "customer_addresses" ("customer_id", "premise_id", "date_address_from", "address_type_code", "date_address_to") VALUES (1018, 1019, '1984-04-15', 'PSC 9946, Box 8044
APO AE 56847', '1985-05-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT premises_type, address_type_code FROM (SELECT LHS.premise_id AS premise_id, LHS.premises_type AS premises_type, LHS.premise_details AS premise_details, RHS.customer_id AS customer_id, RHS.date_address_from AS date_address_from, RHS.address_type_code AS address_type_code, RHS.date_address_to AS date_address_to FROM premises AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.premise_id = RHS.premise_id)) ORDER BY premises_type, address_type_code NULLS LAST;

/*
Gold Result:
('brother', '5868 Crosby Crescent\nGregoryview, AZ 14709')
('brother', 'USNS Gardner\nFPO AA 76851')
('research', 'PSC 9946, Box 8044\nAPO AE 56847')
*/

-- Prediction Query
SELECT T2.premises_type, T1.address_type_code FROM customer_addresses AS T1 JOIN premises AS T2 ON T1.premise_id = T2.premise_id;

/*
Prediction Result:
('brother', 'USNS Gardner\nFPO AA 76851')
('brother', '5868 Crosby Crescent\nGregoryview, AZ 14709')
('research', 'PSC 9946, Box 8044\nAPO AE 56847')
*/