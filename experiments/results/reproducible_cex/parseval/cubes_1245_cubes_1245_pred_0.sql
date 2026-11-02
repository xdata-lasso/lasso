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
INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('lhs_6c256e', 'ref_8f53cb');

INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('lhs_3c810b', 'ref_8f53cb');

-- Inserting into table: ref_colors --
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('pro_22bbfc', 'ref_1bcdd1');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('pro_976074', 'ref_1bcdd1');

-- Inserting into table: ref_product_categories --
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('pro_b0c332', 'ref_9e95cd', 'ref_2e4823');

INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('pro_5e6859', 'ref_9e95cd', 'ref_2e4823');

-- Inserting into table: characteristics --
INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1, 'lhs_6c256e', 'lhs_707658', 'lhs_23d991', 'lhs_e486ab');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (-2147483647, 'lhs_3c810b', 'lhs_32e41b', 'lhs_6605fb', 'lhs_25113b');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (3, 'lhs_6c256e', 'lhs_707658', 'lhs_23d991', 'lhs_e486ab');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (2, 'lhs_3c810b', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'pro_22bbfc', 'pro_b0c332', 'flax', 'pro_632652', 'pro_e5a251', 'pro_caffeb', 'pro_643bef');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483647, 'pro_976074', 'pro_5e6859', 'flax', 'pro_95bad9', 'pro_3446d4', 'pro_4552d8', 'pro_c920cd');

-- Inserting into table: product_characteristics --
INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_7e6e1b');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 2, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 2, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 2, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 2, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_7e6e1b');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_7e6e1b');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_7e6e1b');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_7e6e1b');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, 'rhs_d3b127');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "product_name") AS "n_distinct" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "LHS"."product_id" AS "product_id", "LHS"."product_characteristic_value" AS "product_characteristic_value", "RHS"."color_code" AS "color_code", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM (SELECT "LHS"."characteristic_id" AS "characteristic_id", "LHS"."characteristic_type_code" AS "characteristic_type_code", "LHS"."characteristic_data_type" AS "characteristic_data_type", "LHS"."characteristic_name" AS "characteristic_name", "LHS"."other_characteristic_details" AS "other_characteristic_details", "RHS"."product_id" AS "product_id", "RHS"."product_characteristic_value" AS "product_characteristic_value" FROM "characteristics" AS "LHS" INNER JOIN "product_characteristics" AS "RHS" ON ("LHS"."characteristic_id" = "RHS"."characteristic_id")) AS "LHS" INNER JOIN (SELECT * FROM "products" WHERE ("product_name" = 'flax')) AS RHS ON (LHS.product_id = RHS.product_id))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id JOIN CHARACTERISTICS AS t3 ON t2.characteristic_id = t3.characteristic_id WHERE t1.product_name = 'flax';

/*
Prediction Result:
(30,)
*/