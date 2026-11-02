-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1, 'F', 'Alice', 'Smith', 'alice@example.com', '555-0101');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1, 'REG', '10 Main St', NULL, 'Austin', 'TX', 'cust1@example.com', '555-0201');
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, NULL, 'Cat_C', '2022-01-01 00:00:00', NULL, 'Item C1', 'Desc C1', 5.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (2, NULL, 'Cat_C', '2022-01-02 00:00:00', NULL, 'Item C2', 'Desc C2', 80.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (3, NULL, 'Cat_C', '2022-01-03 00:00:00', NULL, 'Item C3', 'Desc C3', 80.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (4, NULL, 'Cat_B', '2022-01-04 00:00:00', NULL, 'Item B1', 'Desc B1', 18.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (5, NULL, 'Cat_B', '2022-01-05 00:00:00', NULL, 'Item B2', 'Desc B2', 12.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (6, NULL, 'Cat_A', '2022-01-06 00:00:00', NULL, 'Item A1', 'Desc A1', 75.0);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (7, NULL, 'Cat_A', '2022-01-07 00:00:00', NULL, 'Item A2', 'Desc A2', 70.0);
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 101, 'RESOLVED', 'CLOSED', 'DEFECT', '2022-02-01 00:00:00', '2022-02-05 00:00:00');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 102, 'RESOLVED', 'CLOSED', 'BILLING', '2022-02-10 00:00:00', '2022-02-12 00:00:00');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 2, 1, 103, 'PENDING', 'OPEN', 'DELAY', '2022-03-01 00:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanproduct_price AS avg_product_price_, product_category_code FROM (SELECT product_category_code, AVG(product_price) AS meanproduct_price FROM products GROUP BY product_category_code) ORDER BY avg_product_price_, product_category_code NULLS LAST;

/*
Gold Result:
(15.0, 'Cat_B')
(55.0, 'Cat_C')
(72.5, 'Cat_A')
*/

-- Prediction Query
SELECT AVG(product_price), product_category_code FROM products GROUP BY product_category_code;

/*
Prediction Result:
(72.5, 'Cat_A')
(15.0, 'Cat_B')
(55.0, 'Cat_C')
*/