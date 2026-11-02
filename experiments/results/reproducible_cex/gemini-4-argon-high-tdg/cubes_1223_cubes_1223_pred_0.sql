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
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('TYPE1', 'Aroma');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('GRN', 'Green');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('PRP', 'Purple');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('RED', 'Red');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('BLU', 'Blue');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('Herbs', 'Culinary Botanicals', 'Bunch');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('Spices', 'Herbs', 'Gram');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('Seeds', 'Planting Seeds', 'Packet');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (1, 'TYPE1', 'TEXT', 'Scent', 'Strong aroma');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (2, 'TYPE1', 'TEXT', 'Notes', 'Earthy');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'GRN', 'Herbs', 'Thyme', '1.00', '2.50', 'Fresh thyme sprigs', 'Organic');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'PRP', 'Herbs', 'Basil', '1.50', '3.00', 'Purple opal basil', 'Hydroponic');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (3, 'GRN', 'Herbs', 'Mint', '1.20', '2.80', 'Garden peppermint', 'Local');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (4, NULL, 'Herbs', 'Chives', '0.90', '2.00', 'Garlic chives', 'No color assigned');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (5, 'RED', 'Spices', 'Herbs', '3.00', '6.00', 'Herbs', 'Herbs');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (6, 'GRN', 'Seeds', 'Dill', '0.50', '1.50', 'Dill seed pack', 'Heirloom');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 1, 'Pungent');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 2, 'Woody');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (5, 1, 'Spicy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name", "color_description", "product_description" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "ref_colors" AS "LHS" INNER JOIN (SELECT * FROM "products" WHERE ("product_category_code" = 'Herbs')) AS RHS ON (LHS.color_code = RHS.color_code)) ORDER BY product_name, "product_name" NULLS LAST, "color_description" NULLS LAST, "product_description" NULLS LAST;

/*
Gold Result:
('Basil', 'Purple', 'Purple opal basil')
('Mint', 'Green', 'Garden peppermint')
('Thyme', 'Green', 'Fresh thyme sprigs')
*/

-- Prediction Query
SELECT T1.product_name, T2.color_description, T1.product_description FROM products AS T1 JOIN Ref_colors AS T2 ON T1.color_code = T2.color_code WHERE product_category_code = 'Herbs';

/*
Prediction Result:
('Thyme', 'Green', 'Fresh thyme sprigs')
('Basil', 'Purple', 'Purple opal basil')
('Mint', 'Green', 'Garden peppermint')
*/