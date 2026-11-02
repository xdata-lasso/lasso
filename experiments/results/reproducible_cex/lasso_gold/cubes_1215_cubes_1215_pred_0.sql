-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('surface', 'yellow');
INSERT INTO "ref_colors" ("color_code", "color_description") VALUES ('hundred', 'yellow');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('investment', 'Behind probably great in tell.', 'arm');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('able', 'Enter six lawyer institution whatever yet.', 'only');
INSERT INTO "ref_product_categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('two', NULL, NULL);
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1011, 'surface', 'investment', 'Victoria Garcia', 'interesting', 'should', 'Song body court movie cell contain.', 'maintain');
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1012, 'surface', 'two', 'Tracy House', 'time', 'economic', 'Image loss ten total.', 'community');
INSERT INTO "products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1013, 'hundred', 'able', 'Katelyn Lee', 'director', 'article', 'Save article finish anyone live try most arm.', 'movie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "ref_colors" AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) WHERE ("color_description" = 'yellow') ORDER BY product_name, "product_name" NULLS LAST;

/*
Gold Result:
('Katelyn Lee',)
('Tracy House',)
('Victoria Garcia',)
*/

-- Prediction Query
SELECT T1.product_name FROM products AS T1 JOIN ref_colors AS T2 ON T1.color_code = T2.color_code WHERE T2.color_description = 'yellow';

/*
Prediction Result:
('Victoria Garcia',)
('Tracy House',)
('Katelyn Lee',)
*/