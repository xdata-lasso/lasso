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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1086, 'require', 'Lisa Goodwin', '859.477.4688', 'perryrandy@example.com', '04727 Gilbert Common
West Jasonberg, OH 95821', 'movement', 'again');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1087, 'serve', 'Cynthia Allen', '392.640.7581', 'paulmiller@example.org', '43410 Robert Underpass Suite 117
Lake Zacharybury, VT 19319', 'stop', 'in');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1088, 'economy', 'Rachel Mckee', '924-778-2613', 'florescory@example.net', '539 Lopez Skyway
New Theresaland, NC 71814', 'once', 'TV');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1098, 'movie', 'Dr. Cynthia Snyder', '(778)466-9125x1778', 'georgeweber@example.net', '690 Small Plains
Dawnport, NJ 32597', 'listen', 'bill');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1099, 'door', 'Kenneth Mcdonald', '001-789-522-6801x82422', 'megan90@example.org', '7102 Perry Mountain Apt. 592
Michellemouth, VA 45769', 'end', 'apply');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1100, 'campaign', 'Mrs. Stacey Jones', '(384)414-3842x498', 'williamsdarlene@example.net', 'Unit 2588 Box 1537
DPO AE 35559', 'chance', 'fill');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1089, 'many', 'qzavala@example.net', '1981-07-13', '1984-10-16');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1090, 'animal', 'kellycarlos@example.org', '1981-07-14', '1984-10-17');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1091, 'prove', 'ingramjill@example.com', '1981-07-15', '1984-10-18');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1101, 'young', 'kwright@example.com', '1970-03-08', '1973-06-11');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1102, 'if', 'james27@example.net', '1970-03-09', '1973-06-12');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1103, 'treat', 'tjimenez@example.com', '1970-03-10', '1973-06-13');
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1095, NULL, NULL, NULL, NULL);
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1089, 1086, 'Order', '1987-02-19');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1089, 1086, 'Order', '1987-02-20');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1089, 1086, 'Order', '1987-02-21');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1095, 1086, 'Order', '1996-11-05');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1101, 1098, 'Order', '1976-09-14');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1101, 1098, 'Order', '1976-09-15');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1101, 1098, 'Order', '1976-09-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT * FROM "customers" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "customer_id", "outcome_code", COUNT(*) AS "n" FROM "mailshot_customers" GROUP BY "customer_id", "outcome_code") WHERE ("outcome_code" = 'Order' AND n >= 2)) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Dr. Cynthia Snyder',)
('Lisa Goodwin',)
*/

-- Prediction Query
SELECT T2.customer_name FROM mailshot_customers AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id WHERE outcome_code = 'Order' GROUP BY T1.customer_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Lisa Goodwin',)
('Dr. Cynthia Snyder',)
*/