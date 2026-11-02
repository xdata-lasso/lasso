-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('T1', 'General');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('BLK', 'Black');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('C1', 'Hardware', 'Box');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (10, 'T1', 'NUM', 'Length', 'Standard metric');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (20, 'T1', 'NUM', 'Length', 'Standard metric');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (30, 'T1', 'STR', 'Grade', 'Quality level');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (40, 'T1', 'STR', 'Grade', 'Quality level');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (100, 'BLK', 'C1', 'Bolt', '1', '2', 'Steel bolt', 'M8');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (100, 30, 'Grade A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT characteristic_name, other_characteristic_details, characteristic_data_type FROM (SELECT * FROM characteristics AS LHS WHERE NOT EXISTS(SELECT 1 FROM product_characteristics AS RHS WHERE (LHS.characteristic_id = RHS.characteristic_id))) ORDER BY characteristic_name, other_characteristic_details NULLS LAST, characteristic_data_type NULLS LAST;

/*
Gold Result:
('Grade', 'Quality level', 'STR')
('Length', 'Standard metric', 'NUM')
('Length', 'Standard metric', 'NUM')
*/

-- Prediction Query
SELECT characteristic_name, other_characteristic_details, characteristic_data_type FROM CHARACTERISTICS EXCEPT SELECT t1.characteristic_name, t1.other_characteristic_details, t1.characteristic_data_type FROM CHARACTERISTICS AS t1 JOIN product_characteristics AS t2 ON t1.characteristic_id = t2.characteristic_id;

/*
Prediction Result:
('Length', 'Standard metric', 'NUM')
*/