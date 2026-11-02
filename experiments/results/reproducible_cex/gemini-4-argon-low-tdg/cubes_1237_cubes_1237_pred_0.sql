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
INSERT INTO "Ref_Colors" ("color_code", "color_description") VALUES ('C1', 'Red');
INSERT INTO "Ref_Product_Categories" ("product_category_code", "product_category_description", "unit_of_measure") VALUES ('CAT1', 'Seeds', 'kg');
INSERT INTO "Ref_Characteristic_Types" ("characteristic_type_code", "characteristic_type_description") VALUES ('T1', 'Weight');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (1, 'T1', 'num', 'Weight', 'd1');
INSERT INTO "Characteristics" ("characteristic_id", "characteristic_type_code", "characteristic_data_type", "characteristic_name", "other_characteristic_details") VALUES (2, 'T1', 'text', 'Origin', 'd2');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (1, 'C1', 'CAT1', 'sesame', '10', '20', 'desc1', 'det1');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (2, 'C1', 'CAT1', 'sesame', '12', '22', 'desc2', 'det2');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (3, 'C1', 'CAT1', 'poppy', '15', '25', 'desc3', 'det3');
INSERT INTO "Products" ("product_id", "color_code", "product_category_code", "product_name", "typical_buying_price", "typical_selling_price", "product_description", "other_product_details") VALUES (4, 'C1', 'CAT1', 'sesame', '18', '28', 'desc4', 'det4');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, '100g');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 1, '100g');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (1, 2, NULL);
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (2, 1, '200g');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (3, 1, '300g');
INSERT INTO "Product_Characteristics" ("product_id", "characteristic_id", "product_characteristic_value") VALUES (3, 2, '400g');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT * FROM (SELECT "product_id", COUNT(*) AS "n" FROM "product_characteristics" GROUP BY "product_id") AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "products" WHERE ("product_name" <> 'sesame')) AS RHS WHERE (LHS.product_id = RHS.product_id))) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id WHERE t1.product_name = 'sesame';

/*
Prediction Result:
(4,)
*/