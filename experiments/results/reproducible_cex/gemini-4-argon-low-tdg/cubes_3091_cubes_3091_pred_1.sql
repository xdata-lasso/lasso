-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Main Catalog', 'Pub A', '2020-01-01 00:00:00', '2020-06-01 00:00:00');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (10, 1, 'Level 10');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (20, 1, 'Level 20');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (30, 1, 'Level 30');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (10, 20, 1, 2, 3, 'Target_RHS_Z', 'STK10', 100.0, 90.0, 80.0, 'Cap10', 'Len10', 'MatchVal_1', 'Wid10');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (20, 30, 4, 5, 6, 'Target_RHS_A', 'STK20', 200.0, 180.0, 160.0, 'Cap20', 'Len20', 'MatchVal_2', 'Wid20');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (101, 10, 10, 10, 10, 'Source_LHS_A', 'STK101', 50.0, 45.0, 40.0, 'MatchVal_1', 'Diff1', 'Diff2', 'Diff3');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (102, 20, 20, 20, 20, 'Source_LHS_Z', 'STK102', 60.0, 55.0, 50.0, 'MatchVal_2', 'Diff4', 'Diff5', 'Diff6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name_other AS catalog_entry_name FROM (SELECT catalog_level_number AS catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.product_stock_number AS product_stock_number_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_level_number = RHS.catalog_entry_id AND LHS.capacity = RHS.height))) ORDER BY catalog_entry_name;

/*
Gold Result:
('Target_RHS_A',)
('Target_RHS_Z',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY height DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Target_RHS_A',)
*/