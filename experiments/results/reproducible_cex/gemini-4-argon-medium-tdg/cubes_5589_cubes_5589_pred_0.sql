-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join conditions, asymmetric matches (LHS vs RHS), partial matches (only ID or only capacity/height), and ORDER BY.
INSERT INTO Catalogs (catalog_id, catalog_name) VALUES (1, 'Cat 1');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 1, 'L1');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (2, 1, 'L2');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (3, 1, 'L3');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (4, 1, 'L4');
-- LHS (1) matches RHS (10): entry_id 1 = level 1, capacity 'C1' = height 'C1'
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (1, 2, 'Zebra_LHS', 'C1', 'H_DIFF1');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (10, 1, 'Alpha_RHS', 'C_DIFF1', 'C1');
-- LHS (2) matches RHS (20): entry_id 2 = level 2, capacity 'C2' = height 'C2'
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (2, 3, 'Beta_LHS', 'C2', 'H_DIFF2');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (20, 2, 'Omega_RHS', 'C_DIFF2', 'C2');
-- Partial match 1: entry_id 3 = level 3, but capacity ('C3') != height ('NOT_C3')
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (3, 1, 'NoMatch_Cap', 'C3', 'C3');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (30, 3, 'NoMatch_Cap_RHS', 'C3', 'NOT_C3');
-- Partial match 2: capacity ('C4') = height ('C4'), but entry_id 4 != level (1)
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (4, 4, 'NoMatch_ID', 'C4', 'H4');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, catalog_entry_name, capacity, height) VALUES (40, 1, 'NoMatch_ID_RHS', 'C_OTHER', 'C4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, capacity AS height, width, catalog_entry_id_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT catalog_entry_id, catalog_entry_id AS catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_entry_id_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_entry_id AS catalog_entry_id_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.product_stock_number AS product_stock_number_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_entry_id = RHS.catalog_level_number AND LHS.capacity = RHS.height)))) ORDER BY catalog_entry_name;

/*
Gold Result:
('Beta_LHS',)
('Zebra_LHS',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY capacity ASC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra_LHS',)
*/