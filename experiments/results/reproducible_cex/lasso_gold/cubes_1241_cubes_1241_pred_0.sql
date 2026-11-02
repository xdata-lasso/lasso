-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('that', 'Environmental system store beautiful think during let particular.');
INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('factor', 'With modern executive beyond create dinner conference add.');
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('hundred', 'red');
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('none', 'red');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('great', 'Management foot maintain.', 'hear');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('card', 'Animal approach factor want point.', 'soldier');
INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1045, 'that', 'subject', 'fast', 'evening');
INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1049, 'factor', 'military', 'fast', 'board');
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1046, 'hundred', 'great', 'Spencer Haynes', 'fact', 'only', 'Might course drop.', 'investment');
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1050, 'none', 'card', 'Laura Harrison', 'let', 'grow', 'Whole education technology box.', 'attention');
INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1046, 1045, 'middle');
INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1046, 1045, 'member');
INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1050, 1049, 'institution');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_characteristic_value" AS "product_characteristic_value" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."characteristic_id" AS "characteristic_id", "RHS"."characteristic_type_code" AS "characteristic_type_code", "RHS"."characteristic_data_type" AS "characteristic_data_type", "RHS"."characteristic_name" AS "characteristic_name", "RHS"."other_characteristic_details" AS "other_characteristic_details" FROM "ref_colors" AS "LHS" CROSS JOIN "characteristics" AS "RHS") AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) AS "LHS" INNER JOIN "product_characteristics" AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id" AND "LHS"."product_id" = "RHS"."product_id")) WHERE ("color_description" = 'red' AND "characteristic_name" = 'fast') ORDER BY product_name, "product_name" NULLS LAST;

/*
Gold Result:
('Laura Harrison',)
('Spencer Haynes',)
('Spencer Haynes',)
*/

-- Prediction Query
SELECT product_name FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id = t3.characteristic_id JOIN ref_colors AS t4 ON t1.color_code = t4.color_code WHERE t4.color_description = 'red' AND t3.characteristic_name = 'fast';

/*
Prediction Result:
('Spencer Haynes',)
('Spencer Haynes',)
('Laura Harrison',)
*/