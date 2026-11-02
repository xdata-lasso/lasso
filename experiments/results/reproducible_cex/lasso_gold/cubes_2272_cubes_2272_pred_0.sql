-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1017, 1033, 'product', '1988-08-19', '1984-04-15', 'Melinda Jones', 'Fall citizen about reveal.', 1037.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1018, 1026.0, 'determine', '1980-11-12', '2000-01-01', 'Kimberly Sanchez', 'Tree note responsibility defense material.', 1042.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1019, 1031.0, 'religious', '1980-11-13', '2000-01-01', 'Devin Schaefer', 'Central cause seat much section investment on.', 1059.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1020, 1036.0, 'example', '1980-11-14', '2000-01-01', 'Colleen Nguyen', 'Despite young meeting before another body.', 1076.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1029, 1021, 'hear', '1980-11-11', '1984-04-15', 'Arthur James', 'Director allow firm environment.', 1025.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1030, 1038.0, 'collection', '1988-08-20', '2000-01-01', 'Kendra Maddox DVM', 'Will seven medical blood personal.', 1054.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1031, 1043.0, 'structure', '1988-08-21', '2000-01-01', 'Nathan Maldonado', 'Participant check several much single morning a.', 1071.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1032, 1048.0, 'response', '1988-08-22', '2000-01-01', 'Debra Davidson', 'Major born guy world southern dream.', 1088.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_category_code FROM (SELECT * FROM (SELECT * FROM products ORDER BY date_product_discontinued DESC, products.product_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Kimberly Sanchez', 'determine')
*/

-- Prediction Query
SELECT product_name, product_category_code FROM products ORDER BY product_price DESC, products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Debra Davidson', 'response')
*/