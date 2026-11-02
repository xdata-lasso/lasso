-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, duplicates (SELECT vs SELECT DISTINCT), ordering by attribute_name and attribute_id, and LEFT JOIN unmatched NULL filtering.
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Main Catalog', 'Publisher A', '2020-01-01', '2020-06-01');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (10, 1, 'Level 1');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (100, 10, NULL, NULL, NULL, 'Item 1', 'STK1', 10.0, 9.0, 8.0, '10L', '10cm', '10cm', '10cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (101, 10, NULL, NULL, NULL, 'Item 2', 'STK2', 20.0, 18.0, 16.0, '20L', '20cm', '20cm', '20cm');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (1, 'Weight', 'Numeric');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (2, 'Color', 'Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (3, 'Color', 'Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (4, 'Unmatched_Attr', 'Boolean');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (5, 'NonZero_Attr', 'Numeric');
-- Duplicate matches for attribute_id = 1 (tests ALL vs DISTINCT)
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 100, 1, '0');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 101, 1, '0');
-- Tie-breaking on attribute_name ('Color'), reverse order of attribute_id (3 vs 2)
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 100, 3, '0');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 100, 2, '0');
-- Non-zero attribute value (tests WHERE filter)
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 100, 5, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attribute_name, attribute_id FROM (SELECT LHS.attribute_id AS attribute_id, LHS.attribute_name AS attribute_name, LHS.attribute_data_type AS attribute_data_type, RHS.catalog_entry_id AS catalog_entry_id, RHS.catalog_level_number AS catalog_level_number, RHS.attribute_value AS attribute_value FROM attribute_definitions AS LHS LEFT JOIN catalog_contents_additional_attributes AS RHS ON (LHS.attribute_id = RHS.attribute_id)) WHERE (attribute_value = 0) ORDER BY attribute_name, attribute_id NULLS LAST;

/*
Gold Result:
('Color', 2)
('Color', 3)
('Weight', 1)
('Weight', 1)
*/

-- Prediction Query
SELECT t1.attribute_name, t1.attribute_id FROM Attribute_Definitions AS t1 JOIN Catalog_Contents_Additional_Attributes AS t2 ON t1.attribute_id = t2.attribute_id WHERE t2.attribute_value = 0;

/*
Prediction Result:
('Weight', 1)
('Weight', 1)
('Color', 3)
('Color', 2)
*/