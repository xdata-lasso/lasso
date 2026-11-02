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
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C1', 'white');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C2', 'White');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C3', 'off-white');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('white', 'black');
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C4', NULL);
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C5', 'white');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT1', 'General', 'Each');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'C1', 'CAT1', 'Zebra Lamp', '10', '20', 'black', 'none');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'C1', 'CAT1', 'Apple Mug', '5', '15', 'white', 'none');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 'C1', 'CAT1', 'Apple Mug', '8', '18', 'white', 'duplicate name');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, 'C5', 'CAT1', 'Banana Bowl', '12', '25', 'yellow', 'second white color code');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (5, 'C2', 'CAT1', 'Case Sensitive Item', '10', '20', 'white', 'white');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (6, 'C3', 'CAT1', 'Substring Item', '10', '20', 'white', 'white');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (7, 'white', 'CAT1', 'Wrong Column Item', '10', '20', 'white', 'white');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (8, 'C4', 'CAT1', 'Null Color Desc Item', '10', '20', 'white', 'white');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "ref_colors" AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) WHERE ("color_description" = 'white') ORDER BY product_name, "product_name" NULLS LAST;

/*
Gold Result:
('Apple Mug',)
('Apple Mug',)
('Banana Bowl',)
('Zebra Lamp',)
*/

-- Prediction Query
SELECT t1.product_name FROM products AS t1 JOIN ref_colors AS t2 ON t1.color_code = t2.color_code WHERE t2.color_description = 'white';

/*
Prediction Result:
('Zebra Lamp',)
('Apple Mug',)
('Apple Mug',)
('Banana Bowl',)
*/