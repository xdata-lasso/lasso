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
INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('lhs_f86c86', 'ref_8f53cb');

INSERT INTO "ref_characteristic_types" ("characteristic_type_code", "characteristic_type_description") VALUES ('lhs_8b4d48', 'ref_8f53cb');

-- Inserting into table: ref_colors --
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('color_code_1', 'ref_1bcdd1');

-- Inserting into table: ref_product_categories --
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('product_categ_1', 'ref_9e95cd', 'ref_2e4823');

-- Inserting into table: characteristics --
INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1, 'lhs_f86c86', 'lhs_396c85', 'lhs_bce161', 'lhs_22f4cc');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (-2147483647, 'lhs_8b4d48', 'lhs_5bd5d7', 'lhs_31e565', 'lhs_2eb9e9');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (-2147483646, 'lhs_f86c86', 'q_0_099fe3', 'q_0_894a49', 'q_0_8e67ae');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (-2147483645, 'lhs_8b4d48', 'q_0_099fe3', 'q_0_894a49', 'q_0_8e67ae');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (2, 'lhs_8b4d48', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

INSERT INTO "characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (3, 'lhs_8b4d48', 'cha_7ca9e6', 'cha_5ef71d', 'cha_455f0a');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, 'color_code_1', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, 'color_code_1', 'product_categ_1', 'pro_bf129f', 'pro_12a195', 'pro_52b755', 'pro_0bcc33', 'pro_9a6504');

-- Inserting into table: product_characteristics --
INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (4, 2, 'pro_6aab3e');

INSERT INTO "product_characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (5, 3, 'pro_6aab3e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT characteristic_name, other_characteristic_details, characteristic_data_type FROM (SELECT * FROM characteristics AS LHS WHERE NOT EXISTS(SELECT 1 FROM product_characteristics AS RHS WHERE (LHS.characteristic_id = RHS.characteristic_id))) ORDER BY characteristic_name, other_characteristic_details NULLS LAST, characteristic_data_type NULLS LAST;

/*
Gold Result:
('lhs_31e565', 'lhs_2eb9e9', 'lhs_5bd5d7')
('lhs_bce161', 'lhs_22f4cc', 'lhs_396c85')
('q_0_894a49', 'q_0_8e67ae', 'q_0_099fe3')
('q_0_894a49', 'q_0_8e67ae', 'q_0_099fe3')
*/

-- Prediction Query
SELECT characteristic_name, other_characteristic_details, characteristic_data_type FROM CHARACTERISTICS EXCEPT SELECT t1.characteristic_name, t1.other_characteristic_details, t1.characteristic_data_type FROM CHARACTERISTICS AS t1 JOIN product_characteristics AS t2 ON t1.characteristic_id = t2.characteristic_id;

/*
Prediction Result:
('lhs_31e565', 'lhs_2eb9e9', 'lhs_5bd5d7')
('lhs_bce161', 'lhs_22f4cc', 'lhs_396c85')
('q_0_894a49', 'q_0_8e67ae', 'q_0_099fe3')
*/