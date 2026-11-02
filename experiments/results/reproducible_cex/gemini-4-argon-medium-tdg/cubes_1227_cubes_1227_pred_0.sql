-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Focus: ORDER BY direction (ASC vs DESC), secondary sort tie-breaking on characteristic_data_type, and NULLS FIRST vs NULLS LAST behavior.
INSERT INTO "Ref_Characteristic_Types" ("characteristic_type_code", "characteristic_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C1', 'Red');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT1', 'Category 1', 'kg');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1, 'T1', 'z_type', 'Alpha', 'Tie breaker Z');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (2, 'T1', 'a_type', 'Alpha', 'Tie breaker A');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (3, 'T1', NULL, 'Alpha', 'Tie breaker NULL');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (4, 'T1', 'b_type', 'Beta', 'Standard');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (5, 'T1', 'c_type', NULL, 'Null name 1');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (6, 'T1', NULL, NULL, 'Both null');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (100, 'C1', 'CAT1', 'cumin', '10', '20', 'Desc', 'Details');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (100, 1, 'Val1');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (100, 2, 'Val2');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (100, 3, 'Val3');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (100, 4, 'Val4');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (100, 5, 'Val5');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (100, 6, 'Val6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "characteristic_name", "characteristic_data_type" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_characteristic_value" AS "product_characteristic_value" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "RHS"."product_id" AS "product_id", "RHS"."color_code" AS "color_code", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "characteristics" AS "LHS" CROSS JOIN "products" AS "RHS") AS "LHS" INNER JOIN "product_characteristics" AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id" AND "LHS"."product_id" = "RHS"."product_id")) WHERE ("product_name" = 'cumin') ORDER BY characteristic_name, "characteristic_name" NULLS LAST, "characteristic_data_type" NULLS LAST;

/*
Gold Result:
(None, 'c_type')
(None, None)
('Alpha', 'a_type')
('Alpha', 'z_type')
('Alpha', None)
('Beta', 'b_type')
*/

-- Prediction Query
SELECT t3.characteristic_name, t3.characteristic_data_type FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id = t3.characteristic_id WHERE t1.product_name = 'cumin';

/*
Prediction Result:
('Alpha', 'z_type')
('Alpha', 'a_type')
('Alpha', None)
('Beta', 'b_type')
(None, 'c_type')
(None, None)
*/