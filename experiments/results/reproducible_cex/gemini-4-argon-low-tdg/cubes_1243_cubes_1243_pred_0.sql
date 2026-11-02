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
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('RED', 'Red'), ('BLUE', 'Blue');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_A', 'Spices A', 'g'), ('CAT_B', 'Spices B', 'kg');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES
(1, 'RED', 'CAT_B', 'cumin', '10.00', '15.00', 'desc1', 'det1'),
(2, 'BLUE', 'CAT_A', 'cumin', '20.00', '25.00', 'desc2', 'det2'),
(3, 'RED', 'CAT_A', 'turmeric', '5.00', '8.00', 'cumin', 'cumin'),
(4, 'BLUE', 'CAT_B', 'Cumin', '12.00', '18.00', 'desc4', 'det4'),
(5, 'RED', 'CAT_A', 'cumin seeds', '11.00', '16.00', 'desc5', 'det5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_category_code", "typical_buying_price" FROM "products" WHERE ("product_name" = 'cumin') ORDER BY product_category_code, products.product_id NULLS LAST;

/*
Gold Result:
('CAT_A', '20.00')
('CAT_B', '10.00')
*/

-- Prediction Query
SELECT product_category_code, typical_buying_price FROM products WHERE product_name = 'cumin';

/*
Prediction Result:
('CAT_B', '10.00')
('CAT_A', '20.00')
*/