-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1210, 1214, 'success', '1992-07-01', '1996-11-05', 'Christopher Mcdonald', 'Wonder move trade option.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1211, 1219.0, 'success', '1992-07-02', '1996-11-06', 'Christopher Mcdonald', 'Base investment term.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1212, 1224.0, 'success', '1992-07-03', '1996-11-07', 'Christopher Mcdonald', 'Anyone here deep force.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1213, 1229.0, 'success', '1992-07-04', '1996-11-08', 'Christopher Mcdonald', 'Everything week instead strong like see.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1222, 1226, 'area', '1971-04-09', '1975-08-13', 'Mrs. Marie Harrington DDS', 'Wear current after.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1223, 1231.0, 'area', '1971-04-10', '1975-08-14', 'Mrs. Marie Harrington DDS', 'Draw list boy way.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1224, 1236.0, 'area', '1971-04-11', '1975-08-15', 'Mrs. Marie Harrington DDS', 'Record short cold parent security boy standard.', 1218.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1225, 1241.0, 'area', '1971-04-12', '1975-08-16', 'Mrs. Marie Harrington DDS', 'Blue agent find quality when.', 1218.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_category_code FROM (SELECT * FROM (SELECT * FROM (SELECT product_category_code, product_name, MAX(product_price) AS maxproduct_price FROM products GROUP BY product_category_code, product_name) ORDER BY maxproduct_price DESC) LIMIT 1);

/*
Gold Result:
('Mrs. Marie Harrington DDS', 'area')
*/

-- Prediction Query
SELECT product_name, product_category_code FROM products ORDER BY product_price DESC, products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Christopher Mcdonald', 'success')
*/