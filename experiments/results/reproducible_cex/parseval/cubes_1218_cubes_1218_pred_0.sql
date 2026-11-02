-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_characteristic_types --
INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('characteristi_1', 'ref_8f53cb');

INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('lhs_4a9d4a', 'ref_8f53cb');

INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('lhs_a9cba9', 'ref_8f53cb');

-- Inserting into table: ref_colors --
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('rhs_397540', 'ref_1bcdd1');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('rhs_de36a1', 'ref_1bcdd1');

-- Inserting into table: ref_product_categories --
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('rhs_a09b8a', 'ref_9e95cd', 'ref_2e4823');

INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('rhs_3efeed', 'ref_9e95cd', 'ref_2e4823');

-- Inserting into table: characteristics --
INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1, 'characteristi_1', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (-2147483647, 'lhs_4a9d4a', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (-2147483646, 'lhs_4a9d4a', 'cha_7ca9e6', 'hot', 'cha_455f0a');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (2, 'characteristi_1', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (3, 'characteristi_1', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (4, 'lhs_4a9d4a', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'rhs_397540', 'rhs_a09b8a', 'rhs_476b9f', 'rhs_e07161', 'rhs_4100ef', 'rhs_a2c4e4', 'rhs_aa1d71');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483647, 'rhs_de36a1', 'rhs_3efeed', 'rhs_c1c4d6', 'rhs_fb85e1', 'rhs_24b8f6', 'rhs_756b36', 'rhs_fabc36');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'rhs_397540', 'rhs_3efeed', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

-- Inserting into table: product_characteristics --
INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, -2147483647, 'rhs_7ecadb');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, NULL);

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, -2147483647, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, -2147483647, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, -2147483647, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, -2147483647, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, -2147483647, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (-2147483647, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, -2147483647, 'rhs_885f67');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (2, 2, 'pro_6aab3e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "LHS"."product_characteristic_value" AS "product_characteristic_value", "RHS"."n_distinct" AS "n_distinct" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."product_characteristic_value" AS "product_characteristic_value" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "RHS"."product_id" AS "product_id", "RHS"."color_code" AS "color_code", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "characteristics" AS "LHS" CROSS JOIN "products" AS "RHS") AS "LHS" INNER JOIN "product_characteristics" AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id" AND "LHS"."product_id" = "RHS"."product_id")) AS "LHS" INNER JOIN (SELECT "characteristic_data_type", "characteristic_id", COUNT(DISTINCT "characteristic_name") AS "n_distinct" FROM "characteristics" GROUP BY "characteristic_data_type", "characteristic_id") AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id" AND "LHS"."characteristic_data_type" = "RHS"."characteristic_data_type")) WHERE ("characteristic_name" = 'hot') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id = t3.characteristic_id WHERE t3.characteristic_name = 'hot';

/*
Prediction Result:
(0,)
*/