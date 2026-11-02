-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(15), "product_name" TEXT(80), "product_price" REAL);

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "customer_number" TEXT(20), "customer_name" TEXT(80), "customer_address" TEXT(255), "customer_phone" TEXT(80), "customer_email" TEXT(80));

CREATE TABLE "Contacts" ("contact_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(50), "contact_phone" TEXT(80));

CREATE TABLE "Customer_Address_History" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATETIME, "order_status_code" TEXT(15), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_item_id" INTEGER, "order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (0, 'easy', 'expert', 'Steven Miller', '231 Russell Plains Suite 603
Priceshire, UT 03061', '001-596-670-5466x88937', 'ytucker@example.com');
INSERT INTO "customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (150, 'relate', 'respond', 'Steven Miller', 'PSC 9806, Box 9901
APO AP 56680', '(772)704-6537', 'aramirez@example.com');
INSERT INTO "customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (20, 'they', 'beat', 'Robert Oconnell', 'USNS Santos
FPO AP 05777', '001-603-730-9232x71937', 'catherinestuart@example.net');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone, payment_method_code FROM customers ORDER BY customer_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Robert Oconnell', '001-603-730-9232x71937', 'they')
('Steven Miller', '001-596-670-5466x88937', 'easy')
('Steven Miller', '(772)704-6537', 'relate')
*/

-- Prediction Query
SELECT customer_name, customer_phone, payment_method_code FROM customers ORDER BY customer_number DESC, customers.customer_id NULLS LAST;

/*
Prediction Result:
('Steven Miller', '(772)704-6537', 'relate')
('Steven Miller', '001-596-670-5466x88937', 'easy')
('Robert Oconnell', '001-603-730-9232x71937', 'they')
*/