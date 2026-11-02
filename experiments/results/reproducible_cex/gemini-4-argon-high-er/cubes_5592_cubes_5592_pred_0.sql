-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Catalogs (catalog_id, catalog_name) VALUES (1, 'Main');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (8, 1, 'Level 8');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name) VALUES (1, 8, 'B');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name) VALUES (2, 8, 'A');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (8, 1, 1, 'val1');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (8, 2, 1, 'val2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.attribute_id AS attribute_id, LHS.attribute_value AS attribute_value, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id, RHS.previous_entry_id AS previous_entry_id, RHS.next_entry_id AS next_entry_id, RHS.catalog_entry_name AS catalog_entry_name, RHS.product_stock_number AS product_stock_number, RHS.price_in_dollars AS price_in_dollars, RHS.price_in_euros AS price_in_euros, RHS.price_in_pounds AS price_in_pounds, RHS.capacity AS capacity, RHS.length AS LENGTH, RHS.height AS height, RHS.width AS width FROM (SELECT * FROM catalog_contents_additional_attributes WHERE (catalog_level_number = 8)) AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_entry_id = RHS.catalog_entry_id)) ORDER BY catalog_entry_name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT t1.catalog_entry_name FROM Catalog_Contents AS t1 JOIN Catalog_Contents_Additional_Attributes AS t2 ON t1.catalog_entry_id = t2.catalog_entry_id WHERE t2.catalog_level_number = '8';

/*
Prediction Result:
('B',)
('A',)
*/