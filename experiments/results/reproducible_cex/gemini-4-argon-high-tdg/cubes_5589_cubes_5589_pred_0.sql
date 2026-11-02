-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Multiplicity Catalog', 'Pub C', '2023-03-01 00:00:00', '2023-08-01 00:00:00');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 1, 'Level 1');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (5, 1, 'Level 5');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (6, 1, 'Level 6');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (50, 1, 'Level 50');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (1, 50, NULL, NULL, NULL, 'Item_B', 'STK-1', 10.0, 9.0, 8.0, '10L', '1m', '2m', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (2, 1, NULL, NULL, NULL, 'Child_1', 'STK-2', 20.0, 18.0, 16.0, '20L', '1m', '10L', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (3, 1, NULL, NULL, NULL, 'Child_2', 'STK-3', 30.0, 27.0, 24.0, '30L', '1m', '10L', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (4, 1, NULL, NULL, NULL, 'Child_3', 'STK-4', 40.0, 36.0, 32.0, '40L', '1m', '10L', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (5, 50, NULL, NULL, NULL, 'Item_A', 'STK-5', 50.0, 45.0, 40.0, '55L', '1m', '2m', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (6, 50, NULL, NULL, NULL, 'Item_A', 'STK-6', 60.0, 54.0, 48.0, '66L', '1m', '2m', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (7, 5, NULL, NULL, NULL, 'Child_5', 'STK-7', 70.0, 63.0, 56.0, '70L', '1m', '55L', '3m');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (8, 6, NULL, NULL, NULL, 'Child_6', 'STK-8', 80.0, 72.0, 64.0, '80L', '1m', '66L', '3m');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, capacity AS height, width, catalog_entry_id_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT catalog_entry_id, catalog_entry_id AS catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_entry_id_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_entry_id AS catalog_entry_id_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.product_stock_number AS product_stock_number_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_entry_id = RHS.catalog_level_number AND LHS.capacity = RHS.height)))) ORDER BY catalog_entry_name;

/*
Gold Result:
('Item_A',)
('Item_A',)
('Item_B',)
('Item_B',)
('Item_B',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY capacity ASC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Item_B',)
*/