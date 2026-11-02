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
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C1', 'Dark Green');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C2', 'Light Green');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C3', 'Yellow');
INSERT INTO Products (product_id, color_code, product_name) VALUES (1, 'C2', 'chervil');
INSERT INTO Products (product_id, color_code, product_name) VALUES (2, 'C1', 'chervil');
INSERT INTO Products (product_id, color_code, product_name) VALUES (3, 'C1', 'parsley');
INSERT INTO Products (product_id, color_code, product_name) VALUES (4, 'C2', 'chervil');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "color_code", "color_description" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."color_description" AS "color_description" FROM "products" AS "LHS" LEFT JOIN "ref_colors" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) WHERE ("product_name" = 'chervil') ORDER BY color_code, "color_code" NULLS LAST, "color_description" NULLS LAST;

/*
Gold Result:
('C1', 'Dark Green')
('C2', 'Light Green')
('C2', 'Light Green')
*/

-- Prediction Query
SELECT t1.color_code, t2.color_description FROM products AS t1 JOIN ref_colors AS t2 ON t1.color_code = t2.color_code WHERE t1.product_name = 'chervil';

/*
Prediction Result:
('C2', 'Light Green')
('C1', 'Dark Green')
('C2', 'Light Green')
*/