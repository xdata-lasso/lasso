-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Main', 'Pub', '2020-01-01', '2020-01-02');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 1, 'Level 1');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, price_in_dollars, capacity) VALUES (1, 1, 'B', 800.0, '10');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, price_in_dollars, capacity) VALUES (2, 1, 'A', 800.0, '20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name, capacity FROM catalog_contents WHERE (price_in_dollars > 700.0) ORDER BY catalog_entry_name, catalog_contents.catalog_entry_id NULLS LAST;

/*
Gold Result:
('A', '20')
('B', '10')
*/

-- Prediction Query
SELECT catalog_entry_name, capacity FROM Catalog_Contents WHERE price_in_dollars > 700;

/*
Prediction Result:
('B', '10')
('A', '20')
*/