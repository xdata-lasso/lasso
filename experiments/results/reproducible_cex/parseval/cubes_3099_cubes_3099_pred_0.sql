-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: catalog_structure --
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483648, -2147483648, 'cat_32a601');

-- Inserting into table: catalogs --
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483648, 'cat_f063e6', 'cat_c1feab', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: catalog_contents --
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1, -2147483648, -55602865, -59984348, -664303813, 'cat_1bc68b', 'cat_a977e5', 833.684115, 261.897639, 97.952323, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (2, -2147483648, 1610062532, -106629402, 1871297066, 'cat_1bc68b', 'cat_a977e5', 688.4027, 520.784135, 86.520366, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (3, -2147483648, -1633151678, -252690330, 1115440883, 'cat_1bc68b', 'cat_a977e5', 882.963176, 841.297061, 294.861575, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (4, -2147483648, 1908028688, 2122220075, 1072996612, NULL, 'cat_a977e5', 503.083789, 320.851235, 113.643485, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY catalog_entry_name, catalog_contents.catalog_entry_id NULLS LAST;

/*
Gold Result:
(None,)
('cat_1bc68b',)
('cat_1bc68b',)
('cat_1bc68b',)
*/

-- Prediction Query
SELECT DISTINCT (catalog_entry_name) FROM catalog_contents;

/*
Prediction Result:
('cat_1bc68b',)
(None,)
*/