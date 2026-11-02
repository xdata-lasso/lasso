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
-- Tests ORDER BY direction (ASC vs DESC), tie-breaking across all three sorting columns (product_name, color_description, product_description), and NULLS FIRST vs NULLS LAST behavior.
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C1', 'Alpha Color');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C2', 'Beta Color');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C3', NULL);
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('Herbs', 'Herbs Desc', 'kg');
-- Null product_name to test primary sort NULL ordering
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'C1', 'Herbs', NULL, '1.0', '2.0', 'Desc Z', 'Det 1');
-- Tied product_name ('Sage'), testing secondary sort on color_description (including NULL)
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'C2', 'Herbs', 'Sage', '1.0', '2.0', 'Desc A', 'Det 2');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 'C3', 'Herbs', 'Sage', '1.0', '2.0', 'Desc A', 'Det 3');
-- Tied product_name ('Sage') and color_description ('Alpha Color'), testing tertiary sort on product_description (including NULL)
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, 'C1', 'Herbs', 'Sage', '1.0', '2.0', 'Desc B', 'Det 4');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, 'C1', 'Herbs', 'Sage', '1.0', '2.0', 'Desc A', 'Det 5');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (6, 'C1', 'Herbs', 'Sage', '1.0', '2.0', NULL, 'Det 6');
-- Another product_name to test primary sort ASC vs DESC
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (7, 'C1', 'Herbs', 'Coriander', '1.0', '2.0', 'Desc C', 'Det 7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name", "color_description", "product_description" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "ref_colors" AS "LHS" INNER JOIN (SELECT * FROM "products" WHERE ("product_category_code" = 'Herbs')) AS RHS ON (LHS.color_code = RHS.color_code)) ORDER BY product_name, "product_name" NULLS LAST, "color_description" NULLS LAST, "product_description" NULLS LAST;

/*
Gold Result:
(None, 'Alpha Color', 'Desc Z')
('Coriander', 'Alpha Color', 'Desc C')
('Sage', 'Alpha Color', 'Desc A')
('Sage', 'Alpha Color', 'Desc B')
('Sage', 'Alpha Color', None)
('Sage', 'Beta Color', 'Desc A')
('Sage', None, 'Desc A')
*/

-- Prediction Query
SELECT T1.product_name, T2.color_description, T1.product_description FROM products AS T1 JOIN Ref_colors AS T2 ON T1.color_code = T2.color_code WHERE product_category_code = 'Herbs';

/*
Prediction Result:
(None, 'Alpha Color', 'Desc Z')
('Sage', 'Beta Color', 'Desc A')
('Sage', None, 'Desc A')
('Sage', 'Alpha Color', 'Desc B')
('Sage', 'Alpha Color', 'Desc A')
('Sage', 'Alpha Color', None)
('Coriander', 'Alpha Color', 'Desc C')
*/