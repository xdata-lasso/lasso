-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Winter Collection', 'North Press', '2022-01-10', '2022-06-15');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (2, 'Spring Collection', 'South Media', '2022-03-01', '2022-08-20');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (15, 'Summer Collection', 'East House', '2022-05-12', '2022-09-01');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (20, 'Autumn Collection', 'West Prints', '2022-09-01', '2022-11-11');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 20, 'Accessories');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (4, 15, 'Footwear');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (5, 15, 'Outerwear');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (6, 2, 'Zeta Category');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (9, 1, 'Delta Category');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (10, 2, 'Delta Category');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (11, 1, 'Beta Category');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (15, 1, 'Alpha Category');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_level_name, catalog_level_number FROM catalog_structure WHERE (catalog_level_number > 5 OR catalog_level_number > 10) ORDER BY catalog_level_name, catalog_structure.catalog_level_number NULLS LAST;

/*
Gold Result:
('Alpha Category', 15)
('Beta Category', 11)
('Delta Category', 9)
('Delta Category', 10)
('Zeta Category', 6)
*/

-- Prediction Query
SELECT catalog_level_name, catalog_level_number FROM Catalog_Structure WHERE catalog_level_number BETWEEN 5 AND 10;

/*
Prediction Result:
('Outerwear', 5)
('Zeta Category', 6)
('Delta Category', 9)
('Delta Category', 10)
*/