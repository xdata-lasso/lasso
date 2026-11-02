-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, AVG vs SUM/COUNT/MIN/MAX, AVG(DISTINCT) vs AVG(ALL), and inverse relationships between category code order and average price order.
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, NULL, 'CAT_Z', '2020-01-01 00:00:00', NULL, 'Prod 1', 'Desc 1', 10.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (2, 1, 'CAT_Z', '2020-01-02 00:00:00', '2021-01-01 00:00:00', 'Prod 2', 'Desc 2', 10.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (3, NULL, 'CAT_Z', '2020-01-03 00:00:00', NULL, 'Prod 3', 'Desc 3', 40.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (4, NULL, 'CAT_A', '2020-02-01 00:00:00', NULL, 'Prod 4', 'Desc 4', 50.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (5, NULL, 'CAT_M', '2020-03-01 00:00:00', NULL, 'Prod 5', 'Desc 5', 25.5);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (6, NULL, 'CAT_M', '2020-03-02 00:00:00', NULL, 'Prod 6', 'Desc 6', 35.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanproduct_price AS avg_product_price_, product_category_code FROM (SELECT product_category_code, AVG(product_price) AS meanproduct_price FROM products GROUP BY product_category_code) ORDER BY avg_product_price_, product_category_code NULLS LAST;

/*
Gold Result:
(20.0, 'CAT_Z')
(30.25, 'CAT_M')
(50.0, 'CAT_A')
*/

-- Prediction Query
SELECT AVG(product_price), product_category_code FROM products GROUP BY product_category_code;

/*
Prediction Result:
(50.0, 'CAT_A')
(30.25, 'CAT_M')
(20.0, 'CAT_Z')
*/