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
-- Tests basic ordering (ASC vs DESC), inverse correlation between color_code and color_description, duplicate color_description (DISTINCT/GROUP BY mutants), and unreferenced colors (INNER JOIN Products mutants).
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C3', 'Red');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C1', 'Green');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C2', 'Blue');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C4', 'Red');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color_description FROM ref_colors ORDER BY color_description, ref_colors.color_code NULLS LAST;

/*
Gold Result:
('Blue',)
('Green',)
('Red',)
('Red',)
*/

-- Prediction Query
SELECT color_description FROM ref_colors;

/*
Prediction Result:
('Red',)
('Green',)
('Blue',)
('Red',)
*/