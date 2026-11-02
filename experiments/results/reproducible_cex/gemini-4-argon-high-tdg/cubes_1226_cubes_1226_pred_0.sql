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
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C_RED', 'red');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C_YEL', 'yellow');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C_BLU', 'blue');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT_APP', 'Apparel', 'piece');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT_HOM', 'Home Goods', 'unit');
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('TYPE_MAT', 'Material');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (1, 'TYPE_MAT', 'TEXT', 'Fabric', 'Standard fabric');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'C_YEL', 'CAT_HOM', 'Zeta Lamp', '25.00', '45.00', 'Bright desk lamp', 'Boxed');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'C_RED', 'CAT_APP', 'Crimson Jacket', '40.00', '80.00', 'Winter wear', 'Seasonal');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (3, 'C_YEL', 'CAT_APP', 'Alpha Mug', '05.00', '12.00', 'Ceramic mug', 'Fragile');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (4, 'C_YEL', 'CAT_APP', 'Beta Shirt', '15.00', '30.00', 'Cotton shirt', 'Washable');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (5, 'C_BLU', 'CAT_HOM', 'Ocean Rug', '60.00', '110.00', 'Woven rug', 'Rolled');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 1, 'Metal');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (3, 1, 'Ceramic');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (4, 1, 'Cotton');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name", "typical_buying_price", "typical_selling_price" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "ref_colors" AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) WHERE ("color_description" = 'yellow') ORDER BY product_name, "product_name" NULLS LAST, "typical_buying_price" NULLS LAST, "typical_selling_price" NULLS LAST;

/*
Gold Result:
('Alpha Mug', '05.00', '12.00')
('Beta Shirt', '15.00', '30.00')
('Zeta Lamp', '25.00', '45.00')
*/

-- Prediction Query
SELECT t1.product_name, t1.typical_buying_price, t1.typical_selling_price FROM products AS t1 JOIN ref_colors AS t2 ON t1.color_code = t2.color_code WHERE t2.color_description = 'yellow';

/*
Prediction Result:
('Zeta Lamp', '25.00', '45.00')
('Alpha Mug', '05.00', '12.00')
('Beta Shirt', '15.00', '30.00')
*/