-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Cat1', 'Pub1', '2020-01-01', '2020-01-02');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (2, 'Cat2', 'Pub2', '2020-01-01', '2020-01-02');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (3, 'Cat3', 'Pub3', '2020-01-01', '2020-01-02');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (4, 'Cat4', 'Pub4', '2020-01-01', '2020-01-02');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (5, 'Cat5', 'Pub5', '2020-01-01', '2020-01-02');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (10, 'Cat10', 'Pub10', '2020-01-01', '2020-01-02');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (20, 'Cat20', 'Pub20', '2020-01-01', '2020-01-02');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 10, 'Level_Standard_FK_Match');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (2, 1, 'Level_Gold_Match_Z');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (3, 3, 'Level_Gold_Match_A');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (4, 5, 'Level_Partial_Cond1_Only');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (5, 20, 'Level_Unmatched_LHS');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (100, 1, 0, 0, 0, 'Entry_Standard_FK', 'STK100', 10.0, 9.0, 8.0, '10L', '10cm', '10cm', '10cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (2, 1, 0, 0, 0, 'Entry_Gold_Z', 'STK2', 20.0, 18.0, 16.0, '20L', '20cm', '20cm', '20cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (3, 3, 0, 0, 0, 'Entry_Gold_A', 'STK3', 30.0, 27.0, 24.0, '30L', '30cm', '30cm', '30cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (4, 2, 0, 0, 0, 'Entry_Partial_Cond1', 'STK4', 40.0, 36.0, 32.0, '40L', '40cm', '40cm', '40cm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_level_name FROM (SELECT catalog_level_number, catalog_id, catalog_level_name, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number AS catalog_entry_id FROM (SELECT LHS.catalog_level_number AS catalog_level_number, LHS.catalog_id AS catalog_id, LHS.catalog_level_name AS catalog_level_name, RHS.parent_entry_id AS parent_entry_id, RHS.previous_entry_id AS previous_entry_id, RHS.next_entry_id AS next_entry_id, RHS.catalog_entry_name AS catalog_entry_name, RHS.product_stock_number AS product_stock_number, RHS.price_in_dollars AS price_in_dollars, RHS.price_in_euros AS price_in_euros, RHS.price_in_pounds AS price_in_pounds, RHS.capacity AS capacity, RHS.length AS LENGTH, RHS.height AS height, RHS.width AS width FROM catalog_structure AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_level_number = RHS.catalog_entry_id AND LHS.catalog_id = RHS.catalog_level_number))) ORDER BY catalog_level_name;

/*
Gold Result:
('Level_Gold_Match_A',)
('Level_Gold_Match_Z',)
*/

-- Prediction Query
SELECT t2.catalog_level_name FROM catalog_contents AS t1 JOIN catalog_structure AS t2 ON t1.catalog_level_number = t2.catalog_level_number ORDER BY t1.price_in_dollars, t1.catalog_entry_id NULLS LAST, t2.catalog_level_number NULLS LAST LIMIT 1;

/*
Prediction Result:
('Level_Standard_FK_Match',)
*/