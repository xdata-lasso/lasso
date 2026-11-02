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
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('CT1', 'Performance');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C_RED', 'red');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C_BLUE', 'blue');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('PC1', 'Vehicles', 'unit');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (101, 'CT1', 'text', 'fast', 'high speed');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (102, 'CT1', 'text', 'slow', 'low speed');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (10, 'C_RED', 'PC1', 'Zeta', '100', '150', 'desc zeta', 'det zeta');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (11, 'C_RED', 'PC1', 'Alpha', '200', '250', 'desc alpha', 'det alpha');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (12, 'C_RED', 'PC1', 'Beta', '150', '200', 'desc beta', 'det beta');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (13, 'C_RED', 'PC1', 'OnlyRed', '120', '170', 'desc onlyred', 'det onlyred');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (14, 'C_BLUE', 'PC1', 'OnlyFast', '130', '180', 'desc onlyfast', 'det onlyfast');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (15, 'C_BLUE', 'PC1', 'Neither', '110', '160', 'desc neither', 'det neither');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (16, 'C_RED', 'PC1', 'RedNoChar', '90', '140', 'desc nochar', 'det nochar');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (10, 101, 'yes');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (11, 101, 'yes');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (12, 101, 'yes');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (13, 102, 'no');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (14, 101, 'yes');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (15, 102, 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_characteristic_value" AS "product_characteristic_value" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."characteristic_id" AS "characteristic_id", "RHS"."characteristic_type_code" AS "characteristic_type_code", "RHS"."characteristic_data_type" AS "characteristic_data_type", "RHS"."characteristic_name" AS "characteristic_name", "RHS"."other_characteristic_details" AS "other_characteristic_details" FROM "ref_colors" AS "LHS" CROSS JOIN "characteristics" AS "RHS") AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) AS "LHS" INNER JOIN "product_characteristics" AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id" AND "LHS"."product_id" = "RHS"."product_id")) WHERE ("color_description" = 'red' AND "characteristic_name" = 'fast') ORDER BY product_name, "product_name" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT product_name FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id = t3.characteristic_id JOIN ref_colors AS t4 ON t1.color_code = t4.color_code WHERE t4.color_description = 'red' AND t3.characteristic_name = 'fast';

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Beta',)
*/