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
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C1', 'Brown');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C2', 'Green');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_Z', 'Spices Whole', 'oz');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_A', 'Spices Ground', 'grams');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_N', 'Spices Bulk', NULL);
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_OTHER', 'Herbs', 'kg');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'C1', 'CAT_Z', 'cumin', '1.00', '2.00', 'Whole cumin', 'D1');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'C1', 'CAT_A', 'cumin', '1.50', '2.50', 'Ground cumin', 'D2');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 'C1', 'CAT_A', 'cumin', '1.60', '2.60', 'Organic cumin', 'D3');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, NULL, NULL, 'cumin', '0.50', '1.00', 'Uncategorized cumin', 'D4');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, 'C2', 'CAT_N', 'cumin', '5.00', '10.00', 'Bulk cumin', 'D5');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (6, 'C2', 'CAT_OTHER', 'Cumin', '1.00', '2.00', 'Capitalized Cumin', 'D6');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (7, 'C2', 'CAT_OTHER', 'turmeric', '1.00', '2.00', 'cumin', 'cumin');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (8, 'C2', 'CAT_OTHER', 'cumin seeds', '1.00', '2.00', 'Seeds', 'D8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "unit_of_measure" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_category_description" AS "product_category_description", "RHS"."unit_of_measure" AS "unit_of_measure" FROM (SELECT * FROM "products" WHERE ("product_name" = 'cumin')) AS LHS LEFT JOIN ref_product_categories AS RHS ON (LHS.product_category_code = RHS.product_category_code)) ORDER BY unit_of_measure, "unit_of_measure" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('grams',)
('grams',)
('oz',)
*/

-- Prediction Query
SELECT t2.unit_of_measure FROM products AS t1 JOIN ref_product_categories AS t2 ON t1.product_category_code = t2.product_category_code WHERE t1.product_name = 'cumin';

/*
Prediction Result:
('oz',)
('grams',)
('grams',)
(None,)
*/