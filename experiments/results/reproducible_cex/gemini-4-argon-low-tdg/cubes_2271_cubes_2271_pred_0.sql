-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering, projection of address_line_1 and address_line_2, primary sorting by address_line_1, and DISTINCT vs ALL behavior via duplicate address pairs.
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1, 'RET', '300 Oak St', 'Suite 10', 'Austin', 'TX', 'vbogisich@example.org', '555-0101');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (2, 'RET', '100 Main St', 'Apt 4B', 'Boston', 'MA', 'vbogisich@example.org', '555-0102');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (3, 'RET', '100 Main St', 'Apt 4B', 'Boston', 'MA', 'vbogisich@example.org', '555-0103');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (4, 'COM', '200 Pine St', 'Floor 2', 'Chicago', 'IL', 'other@example.org', '555-0104');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (5, 'COM', '400 Elm St', 'Unit 1', 'Denver', 'CO', NULL, '555-0105');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_line_1", "address_line_2" FROM "customers" WHERE ("email_address" = 'vbogisich@example.org') ORDER BY address_line_1, customers.customer_id NULLS LAST;

/*
Gold Result:
('100 Main St', 'Apt 4B')
('100 Main St', 'Apt 4B')
('300 Oak St', 'Suite 10')
*/

-- Prediction Query
SELECT address_line_1, address_line_2 FROM customers WHERE email_address = 'vbogisich@example.org';

/*
Prediction Result:
('300 Oak St', 'Suite 10')
('100 Main St', 'Apt 4B')
('100 Main St', 'Apt 4B')
*/