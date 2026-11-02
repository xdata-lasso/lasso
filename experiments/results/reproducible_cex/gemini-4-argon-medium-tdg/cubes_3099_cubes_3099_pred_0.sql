-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ascending order, duplicate elimination (SELECT vs SELECT DISTINCT), and NULLS LAST vs NULLS FIRST on catalog_entry_name.
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Main Catalog', 'Publisher A', '2023-01-01 00:00:00', '2023-06-01 00:00:00');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 1, 'Level 1');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (1, 1, NULL, NULL, 2, 'Zebra', 'STK-001', 100.0, 90.0, 80.0, '10L', '10cm', '10cm', '10cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (2, 1, 1, 1, 3, 'Alpha', 'STK-002', 50.0, 45.0, 40.0, '5L', '5cm', '5cm', '5cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (3, 1, 1, 2, 4, 'Alpha', 'STK-003', 60.0, 55.0, 50.0, '6L', '6cm', '6cm', '6cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (4, 1, NULL, 3, NULL, NULL, 'STK-004', 10.0, 9.0, 8.0, '1L', '1cm', '1cm', '1cm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY catalog_entry_name, catalog_contents.catalog_entry_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT DISTINCT (catalog_entry_name) FROM catalog_contents;

/*
Prediction Result:
('Zebra',)
('Alpha',)
(None,)
*/