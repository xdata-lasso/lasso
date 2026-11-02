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
-- DATASET 1
-- Tests basic ordering by customer_name, tie-breaking by customer_id (in reverse insertion order),
-- DISTINCT vs ALL (two customers with identical projected columns), and spurious JOINs with child tables.
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (10, 'Credit Card', 'C010', 'Beta Corp', '100 Beta St', '555-0102', 'b2@beta.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (2, 'PayPal', 'C002', 'Beta Corp', '200 Beta St', '555-0101', 'b1@beta.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (5, 'Cash', 'C005', 'Alpha Inc', '500 Alpha Ave', '555-0100', 'a1@alpha.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (8, 'Cash', 'C008', 'Alpha Inc', '800 Alpha Ave', '555-0100', 'a2@alpha.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (1, 'Debit Card', 'C001', 'Gamma LLC', '100 Gamma Rd', '555-0103', 'g@gamma.com');
INSERT INTO "Contacts" ("contact_id", "customer_id", "gender", "first_name", "last_name", "contact_phone") VALUES (1, 10, 'F', 'Jane', 'Doe', '555-9999');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone, payment_method_code FROM customers ORDER BY customer_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alpha Inc', '555-0100', 'Cash')
('Alpha Inc', '555-0100', 'Cash')
('Beta Corp', '555-0101', 'PayPal')
('Beta Corp', '555-0102', 'Credit Card')
('Gamma LLC', '555-0103', 'Debit Card')
*/

-- Prediction Query
SELECT customer_name, customer_phone, payment_method_code FROM customers ORDER BY customer_number DESC, customers.customer_id NULLS LAST;

/*
Prediction Result:
('Beta Corp', '555-0102', 'Credit Card')
('Alpha Inc', '555-0100', 'Cash')
('Alpha Inc', '555-0100', 'Cash')
('Beta Corp', '555-0101', 'PayPal')
('Gamma LLC', '555-0103', 'Debit Card')
*/