-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1, 'F', 'Alice', 'Smith', 'alice@example.com', '555-0101');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1, 'REG', '123 Main St', NULL, 'Springfield', 'IL', 'cust1@example.com', '555-0201');
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, NULL, 'CONF', '2020-01-01 00:00:00', NULL, 'Chocolate', 'White chocolate bar', 4.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (2, 1, 'CONF', '2020-02-01 00:00:00', NULL, 'Chocolate', 'Milk chocolate bar', 3.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (3, 1, 'CONF', '2020-03-01 00:00:00', NULL, 'Chocolate', 'Dark chocolate bar', 5.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (4, NULL, 'CONF', '2020-04-01 00:00:00', NULL, 'Chocolate', 'Milk chocolate bar', 3.75);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (5, NULL, 'CONF', '2020-05-01 00:00:00', NULL, 'Vanilla', 'Chocolate', 2.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (6, NULL, 'CONF', '2020-06-01 00:00:00', NULL, 'Dark Chocolate', 'Bittersweet bar', 6.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (7, NULL, 'CONF', '2020-07-01 00:00:00', NULL, 'chocolate', 'Lowercase name bar', 1.50);
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 2, 1, 101, 'RESOLVED', 'CLOSED', 'QUALITY', '2021-01-10 10:00:00', '2021-01-15 12:00:00');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 2, 1, 102, 'PENDING', 'OPEN', 'PACKAGING', '2021-02-10 10:00:00', NULL);
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 5, 1, 103, 'RESOLVED', 'CLOSED', 'QUALITY', '2021-03-10 10:00:00', '2021-03-12 14:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_description" FROM "products" WHERE ("product_name" = 'Chocolate') ORDER BY product_description, products.product_id NULLS LAST;

/*
Gold Result:
('Dark chocolate bar',)
('Milk chocolate bar',)
('Milk chocolate bar',)
('White chocolate bar',)
*/

-- Prediction Query
SELECT product_description FROM products WHERE product_name = 'Chocolate';

/*
Prediction Result:
('White chocolate bar',)
('Milk chocolate bar',)
('Dark chocolate bar',)
('Milk chocolate bar',)
*/