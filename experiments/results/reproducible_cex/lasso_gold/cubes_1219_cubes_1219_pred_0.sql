-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('determine', 'Reduce raise author play move.');
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('yes', 'Then fire pretty how trip learn enter.');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('election', 'Left establish understand read.', 'discuss');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('employee', 'Much section investment on gun young catch.', 'minute');
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1004, 'determine', 'election', 'Sarah Parsons', 'drop', 'collection', 'Others his other life edge network.', 'activity');
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1005, 'yes', 'employee', 'Ashley Dyer', 'product', 'term', 'Source husband at.', 'white');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, typical_buying_price FROM products ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Ashley Dyer', 'product')
('Sarah Parsons', 'drop')
*/

-- Prediction Query
SELECT product_name, typical_buying_price FROM products;

/*
Prediction Result:
('Sarah Parsons', 'drop')
('Ashley Dyer', 'product')
*/