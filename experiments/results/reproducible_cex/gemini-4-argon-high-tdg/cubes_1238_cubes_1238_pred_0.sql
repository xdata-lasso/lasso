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
INSERT INTO "Ref_Characteristic_Types" ("characteristic_type_code", "characteristic_type_description") VALUES ('GRADE', 'Quality Grade');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('GRN', 'Green');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('YLW', 'Yellow');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_C', 'Fresh Herbs', 'ounce');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_B', 'Dried Herbs', 'gram');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_A', 'Bulk Herbs', 'gram');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT_UNUSED', 'Unused Category', 'kilogram');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1, 'GRADE', 'TEXT', 'Organic', 'Certified');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'GRN', 'CAT_C', 'chervil', '1.00', '2.00', 'Fresh chervil', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'GRN', 'CAT_B', 'chervil', '1.50', '3.00', 'Dried chervil', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 'GRN', 'CAT_A', 'chervil', '2.00', '4.00', 'Bulk chervil', 'None');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, 'YLW', 'CAT_UNUSED', 'parsley', '1.00', '2.00', 'Fresh parsley', 'None');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "unit_of_measure", "product_category_code" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_category_description" AS "product_category_description", "RHS"."unit_of_measure" AS "unit_of_measure" FROM (SELECT * FROM "products" WHERE ("product_name" = 'chervil')) AS LHS LEFT JOIN ref_product_categories AS RHS ON (LHS.product_category_code = RHS.product_category_code)) ORDER BY unit_of_measure, "unit_of_measure" NULLS LAST, "product_category_code" NULLS LAST;

/*
Gold Result:
('gram', 'CAT_A')
('gram', 'CAT_B')
('ounce', 'CAT_C')
*/

-- Prediction Query
SELECT t2.unit_of_measure, t2.product_category_code FROM products AS t1 JOIN ref_product_categories AS t2 ON t1.product_category_code = t2.product_category_code WHERE t1.product_name = 'chervil';

/*
Prediction Result:
('ounce', 'CAT_C')
('gram', 'CAT_B')
('gram', 'CAT_A')
*/