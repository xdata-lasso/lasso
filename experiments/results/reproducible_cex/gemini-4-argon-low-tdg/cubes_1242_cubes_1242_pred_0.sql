-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering, ORDER BY ASC vs DESC, and DISTINCT vs ALL with duplicate product_name values.
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('Spices', 'Aromatic spices', 'Grams');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('Herbs', 'Fresh herbs', 'Ounces');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, NULL, 'Spices', 'Zaatar', '2.00', '4.00', 'Blend', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, NULL, 'Spices', 'Anise', '1.50', '3.00', 'Seed', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, NULL, 'Spices', 'Cumin', '1.00', '2.50', 'Ground', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, NULL, 'Spices', 'Cumin', '1.20', '2.80', 'Whole', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, NULL, 'Herbs', 'Basil', '0.50', '1.50', 'Leaves', 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM "products" WHERE ("product_category_code" = 'Spices') ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Anise',)
('Cumin',)
('Cumin',)
('Zaatar',)
*/

-- Prediction Query
SELECT product_name FROM products WHERE product_category_code = 'Spices';

/*
Prediction Result:
('Zaatar',)
('Anise',)
('Cumin',)
('Cumin',)
*/