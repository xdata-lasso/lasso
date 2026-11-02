-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_colors --
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('color_code_1', 'ref_1bcdd1');

-- Inserting into table: ref_product_categories --
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('pro_394e11', 'ref_9e95cd', 'ref_2e4823');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483648, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483647, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483646, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483645, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483644, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483643, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483642, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483641, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483640, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483639, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483638, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483637, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483636, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483635, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483634, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483633, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483632, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483631, 'color_code_1', 'pro_394e11', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "product_category_code", COUNT(*) AS "n" FROM "products" GROUP BY "product_category_code") WHERE ("product_category_code" = 'Seeds') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM products WHERE product_category_code = 'Seeds';

/*
Prediction Result:
(0,)
*/