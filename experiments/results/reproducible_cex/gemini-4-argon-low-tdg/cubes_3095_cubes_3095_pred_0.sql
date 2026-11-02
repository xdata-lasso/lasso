-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1, 'Winter Catalog', 'Pub B', '2022-01-01 00:00:00', '2023-05-01 00:00:00');
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (2, 'Spring Catalog', 'Pub A', '2021-06-01 00:00:00', '2023-05-01 00:00:00');
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (3, 'Summer Catalog', 'Pub C', '2023-01-01 00:00:00', '2022-11-15 00:00:00');
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (4, 'Fall Catalog', 'Pub A', '2020-01-01 00:00:00', '2024-01-10 00:00:00');
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (10, 1, 'Main Level');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (100, 10, NULL, NULL, NULL, 'Widget', 'STK-1', 10.5, 9.5, 8.5, '10L', '10cm', '10cm', '10cm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_latest_revision FROM (SELECT date_of_latest_revision, COUNT(*) AS n FROM catalogs GROUP BY date_of_latest_revision) WHERE (n >= 1) ORDER BY date_of_latest_revision;

/*
Gold Result:
('2022-11-15 00:00:00',)
('2023-05-01 00:00:00',)
('2024-01-10 00:00:00',)
*/

-- Prediction Query
SELECT date_of_latest_revision FROM Catalogs GROUP BY date_of_latest_revision HAVING COUNT(*) > 1;

/*
Prediction Result:
('2023-05-01 00:00:00',)
*/