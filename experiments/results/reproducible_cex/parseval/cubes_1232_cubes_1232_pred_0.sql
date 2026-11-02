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
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('t1__4430c9', 't2__87ecab');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('_', 't2__87ecab');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('color_code_2', 't2__87ecab');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('A', 'ref_1bcdd1');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('t2__5255c3', 'ref_1bcdd1');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('@', 't2__d061aa');

INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('I', 't2__d061aa');

-- Inserting into table: ref_product_categories --
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('product_categ_1', 'ref_9e95cd', 'ref_2e4823');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483648, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483647, '_', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483646, 'A', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483643, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483642, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483641, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483640, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483639, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (-2147483638, 't1__4430c9', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, '@', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, '_', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT color_description FROM (SELECT LHS.color_code AS color_code, LHS.color_description AS color_description, LHS.n AS n, RHS.product_category_code AS product_category_code, RHS.product_name AS product_name, RHS.typical_buying_price AS typical_buying_price, RHS.typical_selling_price AS typical_selling_price, RHS.product_description AS product_description, RHS.other_product_details AS other_product_details FROM (SELECT color_code, color_description, COUNT(*) AS n FROM ref_colors GROUP BY color_code, color_description) AS LHS INNER JOIN products AS RHS ON (LHS.n = RHS.product_id AND LHS.color_code = RHS.color_code)) ORDER BY color_description;

/*
Gold Result:
*/

-- Prediction Query
SELECT t2.color_description FROM products AS t1 JOIN ref_colors AS t2 ON t1.color_code = t2.color_code GROUP BY t2.color_description ORDER BY COUNT(*) DESC, t2.color_description NULLS LAST LIMIT 1;

/*
Prediction Result:
('t2__87ecab',)
*/