-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: catalog_structure --
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (5, 1, 'lhs_2d7cee');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483647, 1, 'lhs_08345f');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483646, 1, 'lhs_08345f');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483645, 1, 'lhs_08345f');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483644, 1, 'lhs_08345f');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483643, 1, 'lhs_08345f');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483642, 1, 'lhs_08345f');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (4, 1, 'lhs_2d7cee');

-- Inserting into table: catalogs --
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1, 'rhs_a0823c', 'rhs_d0fd7d', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483647, 'rhs_f13c59', 'rhs_48e93e', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (3, 'rhs_a0823c', 'rhs_d0fd7d', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (2, 'cat_f063e6', 'cat_c1feab', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CATALOG_NAME, date_of_publication FROM (SELECT LHS.catalog_level_number AS catalog_level_number, LHS.catalog_id AS catalog_id, LHS.catalog_level_name AS catalog_level_name, RHS.catalog_name AS CATALOG_NAME, RHS.catalog_publisher AS catalog_publisher, RHS.date_of_publication AS date_of_publication, RHS.date_of_latest_revision AS date_of_latest_revision FROM catalog_structure AS LHS INNER JOIN catalogs AS RHS ON (LHS.catalog_id = RHS.catalog_id)) WHERE (catalog_level_number >= 5) ORDER BY CATALOG_NAME, date_of_publication NULLS LAST;

/*
Gold Result:
('rhs_a0823c', '2024-06-15 00:00:00+00:00')
*/

-- Prediction Query
SELECT t1.catalog_name, t1.date_of_publication FROM catalogs AS t1 JOIN catalog_structure AS t2 ON t1.catalog_id = t2.catalog_id WHERE catalog_level_number > 5;

/*
Prediction Result:
*/