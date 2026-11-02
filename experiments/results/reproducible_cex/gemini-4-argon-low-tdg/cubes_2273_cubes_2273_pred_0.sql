-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, NULL, 'FOOD', '2020-01-01 00:00:00', NULL, 'Chocolate', 'Dark Chocolate', 5.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (2, 1, 'FOOD', '2020-01-02 00:00:00', NULL, 'Chocolate', 'Milk Chocolate', 4.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (3, 1, 'FOOD', '2020-01-03 00:00:00', NULL, 'Chocolate', 'Dark Chocolate', 5.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (4, NULL, 'FOOD', '2020-01-04 00:00:00', NULL, 'Chocolate', 'White Chocolate', 6.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (5, NULL, 'FOOD', '2020-01-05 00:00:00', NULL, 'Chocolate', NULL, 3.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (6, NULL, 'FOOD', '2020-01-06 00:00:00', NULL, 'Vanilla', 'Vanilla Bean', 7.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (7, NULL, 'FOOD', '2020-01-07 00:00:00', NULL, 'chocolate', 'Lowercase Chocolate', 4.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (8, NULL, 'FOOD', '2020-01-08 00:00:00', NULL, 'Chocolate Bar', 'Extra Text Chocolate', 2.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (9, NULL, 'FOOD', '2020-01-09 00:00:00', NULL, NULL, 'Null Name Product', 1.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_description" FROM "products" WHERE ("product_name" = 'Chocolate') ORDER BY product_description, products.product_id NULLS LAST;

/*
Gold Result:
(None,)
('Dark Chocolate',)
('Dark Chocolate',)
('Milk Chocolate',)
('White Chocolate',)
*/

-- Prediction Query
SELECT product_description FROM products WHERE product_name = 'Chocolate';

/*
Prediction Result:
('Dark Chocolate',)
('Milk Chocolate',)
('Dark Chocolate',)
('White Chocolate',)
(None,)
*/