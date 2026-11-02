-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1, 'Main Catalog', 'Pub A', '2023-01-01 00:00:00', '2023-06-01 00:00:00');
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (10, 1, 'Level 10');
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (20, 1, 'Level 20');
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (30, 1, 'Level 30');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1, 10, 100, 200, 10, 'LHS_Match_1', 'STK1', 10.0, 9.0, 8.0, '10L', '10cm', '10cm', '10cm');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (10, 20, 101, 1, 300, 'Z_RHS_Target', 'STK2', 20.0, 18.0, 16.0, '20L', '20cm', '20cm', '20cm');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (2, 20, 102, 202, 20, 'LHS_Match_2', 'STK3', 30.0, 27.0, 24.0, '30L', '30cm', '30cm', '30cm');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (20, 30, 103, 2, 303, 'A_RHS_Target', 'STK4', 40.0, 36.0, 32.0, '40L', '40cm', '40cm', '40cm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name_other AS catalog_entry_name FROM (SELECT catalog_level_number AS catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number_other, parent_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, height_other, width_other FROM (SELECT catalog_entry_id, catalog_level_number, parent_entry_id, catalog_entry_id AS previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number_other, parent_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, height_other, width_other FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.product_stock_number AS product_stock_number_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.height AS height_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_entry_id = RHS.previous_entry_id AND LHS.catalog_level_number = RHS.catalog_entry_id)))) ORDER BY catalog_entry_name;

/*
Gold Result:
('A_RHS_Target',)
('Z_RHS_Target',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY height DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_RHS_Target',)
*/