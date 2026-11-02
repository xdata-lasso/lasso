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
INSERT INTO Ref_Characteristic_Types (characteristic_type_code, characteristic_type_description) VALUES ('TYPE1', 'Physical');
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C1', 'White');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('CAT1', 'Seeds', 'kg');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (1, 'TYPE1', 'TEXT', 'Purity', 'High');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (2, 'TYPE1', 'TEXT', 'Origin', 'Local');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (3, 'TYPE1', 'TEXT', 'Grade', 'A');
INSERT INTO Characteristics (characteristic_id, characteristic_type_code, characteristic_data_type, characteristic_name, other_characteristic_details) VALUES (4, 'TYPE1', 'TEXT', 'Moisture', 'Low');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'C1', 'CAT1', 'sesame', '10', '15', 'Batch 1', 'None');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'C1', 'CAT1', 'sesame', '11', '16', 'Batch 2', 'None');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (3, 'C1', 'CAT1', 'sesame', '12', '17', 'Batch 3', 'None');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (4, 'C1', 'CAT1', 'almond', '20', '30', 'Other', 'None');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 1, '99%');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 2, 'India');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (1, 3, 'A1');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (2, 1, '98%');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (3, 1, '97%');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (3, 2, 'Sudan');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (4, 1, '95%');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (4, 2, 'USA');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (4, 3, 'B1');
INSERT INTO Product_Characteristics (product_id, characteristic_id, product_characteristic_value) VALUES (4, 4, '5%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT * FROM (SELECT "product_id", COUNT(*) AS "n" FROM "product_characteristics" GROUP BY "product_id") AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "products" WHERE ("product_name" <> 'sesame')) AS RHS WHERE (LHS.product_id = RHS.product_id))) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM products AS t1 JOIN product_characteristics AS t2 ON t1.product_id = t2.product_id WHERE t1.product_name = 'sesame';

/*
Prediction Result:
(6,)
*/