-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1014, 'discuss', '83172 Contreras Points Suite 798
Rivasside, NV 21362', '4348 Sims Harbor Suite 143
Matthewside, CO 18637', 'East Patrick', 'Georgia', 'maryhowell@example.org', '(371)493-7452');
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1015, 'some', '893 Robinson Mews Suite 065
Ramseymouth, PW 17229', 'Unit 8069 Box 9016
DPO AE 61016', 'North Jorge', 'Massachusetts', 'calebrussell@example.net', '760.636.6909x670');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM complaints AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY email_address, phone_number NULLS LAST;

/*
Gold Result:
('calebrussell@example.net', '760.636.6909x670')
('maryhowell@example.org', '(371)493-7452')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM complaints);

/*
Prediction Result:
('maryhowell@example.org', '(371)493-7452')
('calebrussell@example.net', '760.636.6909x670')
*/