-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1013, 'we', '31509 Brianna Avenue
Lake Crystalbury, CA 04618', '347 Amber Stream
Sanchezfort, AS 53855', 'North Collin', 'Nevada', 'rodney70@example.net', '+1-410-665-1333x8726');
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1014, 1015, 'maintain', '1978-09-09', '1979-10-10', 'Thomas Ramos', 'Better present music address behavior send door.', 1016.5);
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1017, 'investment', 'Todd', 'Lewis', 'kbarrera@example.com', '5646746872');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1013, 1014, 1017, 1018, 'director', 'article', 'Product Failure', '1980-11-11', '1981-01-12');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1013, 1014, 1017, 1018, 'director', 'article', 'Product Failure', '1980-11-11', '1981-01-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "complaint_status_code", "n_distinct" AS "count___" FROM (SELECT "complaint_status_code", "complaint_type_code", COUNT(DISTINCT "complaint_type_code") AS "n_distinct" FROM "complaints" GROUP BY "complaint_status_code", "complaint_type_code") WHERE ("complaint_type_code" = 'Product Failure') ORDER BY complaint_status_code, "complaint_status_code" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('article', 1)
*/

-- Prediction Query
SELECT complaint_status_code, COUNT(*) FROM complaints WHERE complaint_type_code = 'Product Failure' GROUP BY complaint_status_code;

/*
Prediction Result:
('article', 2)
*/