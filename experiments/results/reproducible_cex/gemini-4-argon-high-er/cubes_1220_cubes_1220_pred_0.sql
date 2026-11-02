-- Schema DDL
CREATE TABLE "Ref_Characteristic_Types" ("characteristic_type_code" TEXT(15) PRIMARY KEY, "characteristic_type_description" TEXT(80));

CREATE TABLE "Ref_Colors" ("color_code" TEXT(15) PRIMARY KEY, "color_description" TEXT(80));

CREATE TABLE "Ref_Product_Categories" ("product_category_code" TEXT(15) PRIMARY KEY, "product_category_description" TEXT(80), "unit_of_measure" TEXT(20));

CREATE TABLE "Characteristics" ("characteristic_id" INTEGER PRIMARY KEY, "characteristic_type_code" TEXT(15), "characteristic_data_type" TEXT(10), "characteristic_name" TEXT(80), "other_characteristic_details" TEXT(255), FOREIGN KEY ("characteristic_type_code") REFERENCES "Ref_Characteristic_Types" ("characteristic_type_code"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "color_code" TEXT(15), "product_category_code" TEXT(15), "product_name" TEXT(80), "typical_buying_price" TEXT(20), "typical_selling_price" TEXT(20), "product_description" TEXT(255), "other_product_details" TEXT(255), FOREIGN KEY ("color_code") REFERENCES "Ref_Colors" ("color_code"), FOREIGN KEY ("product_category_code") REFERENCES "Ref_Product_Categories" ("product_category_code"));

CREATE TABLE "Product_Characteristics" ("product_id" INTEGER, "characteristic_id" INTEGER, "product_characteristic_value" TEXT(50), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("characteristic_id") REFERENCES "Characteristics" ("characteristic_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Ref_Colors (color_code, color_description) VALUES ('C1', 'Red');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('A', 'Category A', 'kg');
INSERT INTO Ref_Product_Categories (product_category_code, product_category_description, unit_of_measure) VALUES ('B', 'Category B', 'kg');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (1, 'C1', 'B', 'flax', '10', '20', 'desc', 'details');
INSERT INTO Products (product_id, color_code, product_category_code, product_name, typical_buying_price, typical_selling_price, product_description, other_product_details) VALUES (2, 'C1', 'A', 'flax', '10', '20', 'desc', 'details');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_category_code" FROM "products" WHERE ("product_name" = 'flax') ORDER BY product_category_code, products.product_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT product_category_code FROM products WHERE product_name = 'flax';

/*
Prediction Result:
('B',)
('A',)
*/