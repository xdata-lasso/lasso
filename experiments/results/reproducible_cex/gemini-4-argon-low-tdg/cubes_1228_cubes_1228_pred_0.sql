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
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('BRN', 'Brown');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT1', 'Spices', 'z_unit');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT2', 'Herbs', 'a_unit');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT3', 'Seeds', NULL);
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT4', 'Extracts', 'm_unit');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'BRN', 'CAT1', 'cumin', '10', '20', 'Ground cumin', 'Details 1');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'BRN', 'CAT1', 'cumin', '12', '22', 'Whole cumin', 'Details 2');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 'BRN', 'CAT2', 'cumin', '15', '25', 'Organic cumin', 'Details 3');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, 'BRN', NULL, 'cumin', '8', '16', 'Bulk cumin', 'Details 4');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, 'BRN', 'CAT3', 'cumin', '9', '18', 'Roasted cumin', 'Details 5');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (6, 'BRN', 'CAT4', 'turmeric', '10', '20', 'Ground turmeric', 'Details 6');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (7, 'BRN', 'CAT4', 'Cumin', '10', '20', 'Capitalized Cumin', 'Details 7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "unit_of_measure" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_category_description" AS "product_category_description", "RHS"."unit_of_measure" AS "unit_of_measure" FROM (SELECT * FROM "products" WHERE ("product_name" = 'cumin')) AS LHS LEFT JOIN ref_product_categories AS RHS ON (LHS.product_category_code = RHS.product_category_code)) ORDER BY unit_of_measure, "unit_of_measure" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('a_unit',)
('z_unit',)
('z_unit',)
*/

-- Prediction Query
SELECT t2.unit_of_measure FROM products AS t1 JOIN ref_product_categories AS t2 ON t1.product_category_code = t2.product_category_code WHERE t1.product_name = 'cumin';

/*
Prediction Result:
('z_unit',)
('z_unit',)
('a_unit',)
(None,)
*/