-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL (duplicate address_line_1 and address_line_2 for different matching customers) and ORDER BY customer_id tie-breaking.
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (20, 'Res', '742 Evergreen Terrace', 'Apt 2', 'Springfield', 'OR', 'vbogisich@example.org', '555-0201');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (10, 'Bus', '742 Evergreen Terrace', 'Apt 1', 'Springfield', 'OR', 'vbogisich@example.org', '555-0202');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (30, 'Res', '742 Evergreen Terrace', 'Apt 2', 'Shelbyville', 'OR', 'vbogisich@example.org', '555-0203');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (5, 'Bus', '999 Zebra Way', 'Suite 100', 'Portland', 'OR', 'vbogisich@example.org', '555-0204');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (40, 'Res', '111 Alpha St', 'Suite 900', 'Eugene', 'OR', 'vbogisich@example.org', '555-0205');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_line_1", "address_line_2" FROM "customers" WHERE ("email_address" = 'vbogisich@example.org') ORDER BY address_line_1, customers.customer_id NULLS LAST;

/*
Gold Result:
('111 Alpha St', 'Suite 900')
('742 Evergreen Terrace', 'Apt 1')
('742 Evergreen Terrace', 'Apt 2')
('742 Evergreen Terrace', 'Apt 2')
('999 Zebra Way', 'Suite 100')
*/

-- Prediction Query
SELECT address_line_1, address_line_2 FROM customers WHERE email_address = 'vbogisich@example.org';

/*
Prediction Result:
('999 Zebra Way', 'Suite 100')
('742 Evergreen Terrace', 'Apt 1')
('742 Evergreen Terrace', 'Apt 2')
('742 Evergreen Terrace', 'Apt 2')
('111 Alpha St', 'Suite 900')
*/