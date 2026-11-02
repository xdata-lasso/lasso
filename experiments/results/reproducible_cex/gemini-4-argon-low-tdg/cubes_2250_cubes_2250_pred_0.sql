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
-- DATASET 2
-- Tests outcome_code filtering, grouping by outcome_code, NULL values, and COUNT(DISTINCT mailshot_id) vs COUNT(*)
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Eve');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Frank');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Grace');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, NULL);
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Aaron');
INSERT INTO Mailshot_Campaigns (mailshot_id, mailshot_name) VALUES (201, 'Camp 1');
INSERT INTO Mailshot_Campaigns (mailshot_id, mailshot_name) VALUES (202, 'Camp 2');
-- Eve: 1 'Order' and 2 'No Response' (Total = 3, 'Order' = 1; kills mutants missing outcome_code filter before/after grouping)
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (201, 1, 'Order');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (201, 1, 'No Response');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (202, 1, 'No Response');
-- Frank: 2 'Order's with the SAME mailshot_id and NULL date (Kills COUNT(DISTINCT mailshot_id) and COUNT(mailshot_customer_date))
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (201, 2, 'Order', NULL);
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (201, 2, 'Order', NULL);
-- Grace: 2 'order' (lowercase) and 2 NULL outcomes (Tests case sensitivity and NULL outcome handling)
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (201, 3, 'order');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (202, 3, 'order');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (201, 3, NULL);
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (202, 3, NULL);
-- Customer 4 (NULL name): 2 'Order's (Tests NULLS LAST ordering and COUNT(customer_name) mutants)
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (201, 4, 'Order');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (202, 4, 'Order');
-- Aaron: 2 'Order's (Tests alphabetical sorting alongside NULL customer_name)
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (201, 5, 'Order');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code) VALUES (202, 5, 'Order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT * FROM "customers" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "customer_id", "outcome_code", COUNT(*) AS "n" FROM "mailshot_customers" GROUP BY "customer_id", "outcome_code") WHERE ("outcome_code" = 'Order' AND n >= 2)) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Frank',)
*/

-- Prediction Query
SELECT T2.customer_name FROM mailshot_customers AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id WHERE outcome_code = 'Order' GROUP BY T1.customer_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Frank',)
(None,)
('Aaron',)
*/