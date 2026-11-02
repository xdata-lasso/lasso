-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1013, 'live', '50983 Adrian Station
East Carloston, VI 43810', '7382 Sanchez Mountains
Leeville, TN 56999', 'Rodneymouth', 'Washington', 'nuneztracey@example.org', '4658133387');
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1019, 'article', '500 Shaw Walk
North Susan, CO 24857', '361 Beth Canyon
South Dianeshire, NC 41968', 'Jamesmouth', 'Kansas', 'randy47@example.com', '001-310-579-9118x38425');
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1014, 1015, 'cover', '1978-09-09', '1979-10-10', 'David Leblanc', 'Space task better present music address.', 1016.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1020, 1021, 'hope', '1982-02-13', '1983-03-14', 'Jeffrey Daniels', 'Particularly would pressure account stage.', 1022.5);
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1017, 'better', 'Sara', 'Allison', 'richardolson@example.com', '9264064746');
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1023, 'firm', 'Sarah', 'Garcia', 'josephpreston@example.net', '+1-924-649-3534');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1013, 1014, 1017, 1018, 'customer', 'fine', 'director', '1980-11-11', '1981-01-12');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1019, 1020, 1023, 1024, 'western', 'whatever', 'director', '1984-04-15', '1985-05-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_complaint_type_code_ FROM (SELECT complaint_outcome_code, COUNT(DISTINCT complaint_type_code) AS n_distinct FROM complaints GROUP BY complaint_outcome_code) ORDER BY count_distinct_complaint_type_code_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT complaint_type_code) FROM complaints;

/*
Prediction Result:
(1,)
*/