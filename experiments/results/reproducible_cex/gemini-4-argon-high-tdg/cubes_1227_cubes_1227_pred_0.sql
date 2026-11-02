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
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('CHEM', 'Chemical property');
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('PHYS', 'Physical property');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('BRN', 'Brown');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('YLW', 'Yellow');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('SPICE', 'Spices and Herbs', 'grams');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (1, 'PHYS', 'text', 'wrong_id_match', 'Matches product_id 1 but linked to product 2');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (2, 'PHYS', 'float', 'weight', 'Net weight');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (3, 'CHEM', 'text', 'aroma', 'Aroma profile');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (4, 'CHEM', 'num', 'acidity', 'pH level');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (5, 'PHYS', 'bool', 'unlinked_char', 'Not linked to any product');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'BRN', 'SPICE', 'cumin', '2.50', '5.00', 'Whole cumin', 'Organic');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'YLW', 'SPICE', 'coriander', '1.80', '3.90', 'Whole coriander', 'Standard');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (3, 'BRN', 'SPICE', 'Cumin', '2.60', '5.20', 'Uppercase product name', 'Standard');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 2, '100g');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 3, 'earthy');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 4, '6.5');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (2, 1, 'coriander_only');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (3, 1, 'uppercase_cumin_only');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "characteristic_name", "characteristic_data_type" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_characteristic_value" AS "product_characteristic_value" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "RHS"."product_id" AS "product_id", "RHS"."color_code" AS "color_code", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "characteristics" AS "LHS" CROSS JOIN "products" AS "RHS") AS "LHS" INNER JOIN "product_characteristics" AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id" AND "LHS"."product_id" = "RHS"."product_id")) WHERE ("product_name" = 'cumin') ORDER BY characteristic_name, "characteristic_name" NULLS LAST, "characteristic_data_type" NULLS LAST;

/*
Gold Result:
('acidity', 'num')
('aroma', 'text')
('weight', 'float')
*/

-- Prediction Query
SELECT t3.characteristic_name, t3.characteristic_data_type FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id = t3.characteristic_id WHERE t1.product_name = 'cumin';

/*
Prediction Result:
('weight', 'float')
('aroma', 'text')
('acidity', 'num')
*/