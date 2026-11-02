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
-- Tests basic color filtering (exact match 'white' vs 'White', 'white ', 'black'), ordering, and duplicate product names (SELECT vs SELECT DISTINCT).
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('W1', 'white');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('W2', 'White');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('W3', 'white ');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('B1', 'black');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT1', 'Electronics', 'piece');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT2', 'Apparel', 'item');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'W1', 'CAT1', 'Zebra Lamp', '10', '20', 'white', 'details');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'W1', 'CAT2', 'Alpha Shirt', '5', '15', 'desc', 'other');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (3, 'W1', 'CAT1', 'Alpha Shirt', '8', '18', 'desc2', 'other2');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (4, 'W2', 'CAT1', 'Beta Phone', '100', '200', 'white', 'white');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (5, 'W3', 'CAT1', 'Gamma Mouse', '10', '20', 'white', 'white');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (6, 'B1', 'CAT1', 'white', '10', '20', 'white', 'white');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_category_description" AS "product_category_description", "LHS"."unit_of_measure" AS "unit_of_measure", "LHS"."product_id" AS "product_id", "LHS"."product_name" AS "product_name", "LHS"."typical_buying_price" AS "typical_buying_price", "LHS"."typical_selling_price" AS "typical_selling_price", "LHS"."product_description" AS "product_description", "LHS"."other_product_details" AS "other_product_details" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "LHS"."product_category_code" AS "product_category_code", "LHS"."product_category_description" AS "product_category_description", "LHS"."unit_of_measure" AS "unit_of_measure", "RHS"."product_id" AS "product_id", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_category_description" AS "product_category_description", "RHS"."unit_of_measure" AS "unit_of_measure" FROM "ref_colors" AS "LHS" CROSS JOIN "ref_product_categories" AS "RHS") AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code" AND "LHS"."product_category_code" = "RHS"."product_category_code")) AS "LHS" INNER JOIN (SELECT * FROM "ref_colors" WHERE ("color_description" = 'white')) AS RHS ON (LHS.color_code = RHS.color_code AND LHS.color_description = RHS.color_description)) ORDER BY product_name, "product_name" NULLS LAST;

/*
Gold Result:
('Alpha Shirt',)
('Alpha Shirt',)
('Zebra Lamp',)
*/

-- Prediction Query
SELECT t1.product_name FROM products AS t1 JOIN ref_product_categories AS t2 ON t1.product_category_code = t2.product_category_code JOIN ref_colors AS t3 ON t1.color_code = t3.color_code WHERE t3.color_description = 'white' AND t2.unit_of_measure <> 'Handful';

/*
Prediction Result:
('Zebra Lamp',)
('Alpha Shirt',)
('Alpha Shirt',)
*/