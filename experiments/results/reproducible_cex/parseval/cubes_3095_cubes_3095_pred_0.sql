-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: catalogs --
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483648, 'cat_f063e6', 'cat_c1feab', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483647, 'cat_f063e6', 'cat_c1feab', '2025-11-23 07:28:46+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483646, 'cat_f063e6', 'cat_c1feab', '2025-10-14 06:39:08+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (2, 'cat_f063e6', 'cat_c1feab', '2025-06-10 18:20:47+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (3, 'cat_f063e6', 'cat_c1feab', '2024-02-22 05:22:28+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483645, 'cat_f063e6', 'cat_c1feab', '2021-05-28 17:00:04+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483642, 'cat_f063e6', 'cat_c1feab', '2024-02-19 01:18:26+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483641, 'cat_f063e6', 'cat_c1feab', '2022-06-06 02:35:43+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483640, 'cat_f063e6', 'cat_c1feab', '2022-12-08 21:38:59+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483639, 'cat_f063e6', 'cat_c1feab', '2023-01-16 20:10:41+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483638, 'cat_f063e6', 'cat_c1feab', '2022-03-24 16:30:12+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483637, 'cat_f063e6', 'cat_c1feab', '2020-04-30 03:21:27+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483636, 'cat_f063e6', 'cat_c1feab', '2020-10-31 07:51:16+00:00', NULL);

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483635, 'cat_f063e6', 'cat_c1feab', '2022-06-28 11:34:24+00:00', NULL);

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483634, 'cat_f063e6', 'cat_c1feab', '2021-06-17 14:22:38+00:00', NULL);

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (4, 'cat_f063e6', 'cat_c1feab', '2024-11-14 12:35:58+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (5, 'cat_f063e6', 'cat_c1feab', '2024-09-28 03:06:45+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483631, 'cat_f063e6', 'cat_c1feab', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (6, 'cat_f063e6', 'cat_c1feab', '2025-11-23 07:28:46+00:00', '2025-10-14 06:39:08+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_latest_revision FROM (SELECT date_of_latest_revision, COUNT(*) AS n FROM catalogs GROUP BY date_of_latest_revision) WHERE (n >= 1) ORDER BY date_of_latest_revision;

/*
Gold Result:
(None,)
('2024-06-15 00:00:00+00:00',)
('2025-10-14 06:39:08+00:00',)
*/

-- Prediction Query
SELECT date_of_latest_revision FROM Catalogs GROUP BY date_of_latest_revision HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('2024-06-15 00:00:00+00:00',)
*/