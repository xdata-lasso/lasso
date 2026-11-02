-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (10, NULL, 'CANDY', '2019-01-01 00:00:00', NULL, 'Chocolate', 'Zebra Striped Chocolate', 7.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (20, NULL, 'CANDY', '2019-05-01 00:00:00', NULL, 'Chocolate', 'Almond Chocolate', 8.00);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (30, NULL, 'CANDY', '2019-06-01 00:00:00', NULL, 'Chocolate', 'Almond Chocolate', 8.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (40, NULL, 'CANDY', '2019-07-01 00:00:00', NULL, 'Chocolate', NULL, 5.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_description" FROM "products" WHERE ("product_name" = 'Chocolate') ORDER BY product_description, products.product_id NULLS LAST;

/*
Gold Result:
(None,)
('Almond Chocolate',)
('Almond Chocolate',)
('Zebra Striped Chocolate',)
*/

-- Prediction Query
SELECT product_description FROM products WHERE product_name = 'Chocolate';

/*
Prediction Result:
('Zebra Striped Chocolate',)
('Almond Chocolate',)
('Almond Chocolate',)
(None,)
*/