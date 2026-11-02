-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, 1, 'pro_f0e129', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'pro_5ba496', 'pro_a425c9', 1.0);

INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (-2147483647, 1, 'pro_a7bae5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'pro_60e8b5', 'pro_aa9bbc', 1.0);

INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (-1, -55602865, 'pro_c1719f', '2024-02-19 01:18:26+00:00', '1970-01-01 02:08:39+00:00', 'pro_bf129f', 'pro_0bcc33', 0.0003);

INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (0, -921145356, 'pro_c1719f', '2023-01-16 20:10:41+00:00', '1970-01-01 00:00:00+00:00', 'pro_bf129f', 'pro_0bcc33', 0.0004);

INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (-2147483644, -1022641847, 'q_1_55ce3c', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00', 'q_1_fe7507', 'pro_0bcc33', 0.0005);

INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (-2147483643, 247012447, 'q_1_55ce3c', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'q_1_fe7507', 'pro_0bcc33', 0.0006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_category_code FROM (SELECT * FROM (SELECT * FROM products ORDER BY date_product_discontinued DESC, products.product_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_fe7507', 'q_1_55ce3c')
*/

-- Prediction Query
SELECT product_name, product_category_code FROM products ORDER BY product_price DESC, products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('pro_60e8b5', 'pro_a7bae5')
*/