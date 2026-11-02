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
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('Y1', 'yellow');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('Y2', 'yellow');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('Y_EMPTY', 'yellow');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('yellow', 'blue');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('R1', 'red');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT1', 'Fruit', 'kg');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT2', 'yellow', 'unit');
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('TYPE1', 'Physical');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (10, 'TYPE1', 'TEXT', 'Weight', 'Grade A');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (20, 'TYPE1', 'TEXT', 'Origin', 'Organic');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'Y2', NULL, 'Lemon', '50.00', '20.00', 'Sour lemon', 'D1');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'Y1', 'CAT1', 'Mango', '10.00', '90.00', 'Sweet mango', 'D2');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (3, 'Y1', 'CAT1', 'Apricot', '30.00', '50.00', 'Fresh apricot', 'D3');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (4, 'yellow', 'CAT2', 'Blueberry', '20.00', '40.00', 'yellow', 'yellow');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (5, 'R1', 'CAT1', 'yellow', '15.00', '25.00', 'Red item named yellow', 'D5');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (6, NULL, 'CAT1', 'UncoloredItem', '5.00', '10.00', 'No color assigned', 'D6');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (2, 10, '500g');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (2, 20, 'Tropical');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (3, 10, '200g');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name" FROM (SELECT "LHS"."color_code" AS "color_code", "LHS"."color_description" AS "color_description", "RHS"."product_id" AS "product_id", "RHS"."product_category_code" AS "product_category_code", "RHS"."product_name" AS "product_name", "RHS"."typical_buying_price" AS "typical_buying_price", "RHS"."typical_selling_price" AS "typical_selling_price", "RHS"."product_description" AS "product_description", "RHS"."other_product_details" AS "other_product_details" FROM "ref_colors" AS "LHS" INNER JOIN "products" AS "RHS" ON ("LHS"."color_code" = "RHS"."color_code")) WHERE ("color_description" = 'yellow') ORDER BY product_name, "product_name" NULLS LAST;

/*
Gold Result:
('Apricot',)
('Lemon',)
('Mango',)
*/

-- Prediction Query
SELECT T1.product_name FROM products AS T1 JOIN ref_colors AS T2 ON T1.color_code = T2.color_code WHERE T2.color_description = 'yellow';

/*
Prediction Result:
('Lemon',)
('Mango',)
('Apricot',)
*/