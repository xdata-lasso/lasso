-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Characteristic_Types" ("characteristic_type_code", "characteristic_type_description") VALUES ('catnip19', 'catnip');
INSERT INTO "Ref_Characteristic_Types" ("characteristic_type_code", "characteristic_type_description") VALUES ('catnip18', 'catnip');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('catnip42', NULL);
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('catnip20', 'catnip');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('catnip37', 'catnip', 'catnip');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('catnip30', 'catnip', 'catnip');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (22, 'catnip18', 'catnip', 'catnip', 'catnip');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (21, 'catnip18', 'catnip', 'catnip', 'catnip');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (36, 'catnip42', 'catnip37', 'catnip', 'catnip38', 'catnip39', 'catnip40', 'catnip41');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (28, NULL, 'catnip30', 'catnip', 'catnip31', 'catnip32', 'catnip33', 'catnip34');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (28, 22, 'catnip');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (36, 22, 'catnip');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "color_description" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."color_code" AS "color_code", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details", "RHS"."color_description" AS "color_description" FROM "products" AS "LHS" LEFT JOIN "ref_colors" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) WHERE ("product_name" = 'catnip') ORDER BY color_description, "color_description" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT t2.color_description FROM products AS t1 JOIN ref_colors AS t2 ON t1.color_code = t2.color_code WHERE t1.product_name = 'catnip';

/*
Prediction Result:
(None,)
*/