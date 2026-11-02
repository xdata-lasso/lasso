-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions on price_in_dollars (700.0, < 700.0, > 700.0, NULL) and column selection confusion (e.g. euros/pounds vs dollars, length/width vs capacity).
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Main Catalog', 'Publisher A', '2023-01-01', '2023-06-01');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (10, 1, 'Electronics');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES
(1, 10, NULL, NULL, 2, 'Item_Exact_700', 'STK1', 700.0, 800.0, 800.0, 'Cap_700', 'Len_1', 'Hei_1', 'Wid_1'),
(2, 10, NULL, 1, 3, 'Item_Just_Under', 'STK2', 699.99, 750.0, 750.0, 'Cap_699', 'Len_2', 'Hei_2', 'Wid_2'),
(3, 10, NULL, 2, 4, 'Item_Just_Over', 'STK3', 700.01, 600.0, 500.0, 'Cap_700_01', 'Len_3', 'Hei_3', 'Wid_3'),
(4, 10, NULL, 3, 5, 'Item_Null_Price', 'STK4', NULL, 900.0, 900.0, 'Cap_Null', 'Len_4', 'Hei_4', 'Wid_4'),
(5, 10, NULL, 4, NULL, 'Item_High_Price', 'STK5', 1500.0, 650.0, 600.0, 'Cap_1500', 'Len_5', 'Hei_5', 'Wid_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name, capacity FROM catalog_contents WHERE (price_in_dollars > 700.0) ORDER BY catalog_entry_name, catalog_contents.catalog_entry_id NULLS LAST;

/*
Gold Result:
('Item_High_Price', 'Cap_1500')
('Item_Just_Over', 'Cap_700_01')
*/

-- Prediction Query
SELECT catalog_entry_name, capacity FROM Catalog_Contents WHERE price_in_dollars > 700;

/*
Prediction Result:
('Item_Just_Over', 'Cap_700_01')
('Item_High_Price', 'Cap_1500')
*/