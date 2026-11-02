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
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C1', 'Red');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT1', 'Electronics', 'Piece');
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('T1', 'Weight');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (1, 'T1', 'Numeric', 'Net Weight', 'kg');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (30, 'C1', 'CAT1', 'Alpha', '50.00', '90.00', 'Desc 30', 'Details 30');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (10, 'C1', 'CAT1', 'Alpha', '20.00', '40.00', 'Desc 10', 'Details 10');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (20, 'C1', 'CAT1', 'Alpha', '90.00', '10.00', 'Desc 20', 'Details 20');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (40, 'C1', 'CAT1', 'Beta', '15.00', '25.00', 'Desc 40', 'Details 40');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (50, 'C1', 'CAT1', 'Beta', '15.00', '30.00', 'Desc 50', 'Details 50');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (5, 'C1', 'CAT1', 'Gamma', '5.00', '8.00', 'Desc 5', 'Details 5');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (30, 1, '1.5');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (10, 1, '1.0');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (20, 1, '2.0');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (40, 1, '3.0');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (50, 1, '3.5');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (5, 1, '0.5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, typical_buying_price FROM products ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Alpha', '20.00')
('Alpha', '90.00')
('Alpha', '50.00')
('Beta', '15.00')
('Beta', '15.00')
('Gamma', '5.00')
*/

-- Prediction Query
SELECT product_name, typical_buying_price FROM products;

/*
Prediction Result:
('Gamma', '5.00')
('Alpha', '20.00')
('Alpha', '90.00')
('Alpha', '50.00')
('Beta', '15.00')
('Beta', '15.00')
*/