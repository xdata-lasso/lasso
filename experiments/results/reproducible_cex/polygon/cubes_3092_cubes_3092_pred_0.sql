-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Attribute_Definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (10, '12', '12');
INSERT INTO "Attribute_Definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (9, '12', '12');
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (11, '12', '12', 12, 12);
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (12, '12', '12', 12, 12);
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (6, 12, '15');
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (5, 12, '16');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (14, 5, 12, 12, 12, '12', '12', 12, 12, 12, '12', '12', '12', '12');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (13, 5, 12, 12, 12, '12', '12', 12, 12, 12, '12', '12', '12', '12');
INSERT INTO "Catalog_Contents_Additional_Attributes" ("catalog_level_number", "catalog_entry_id", "attribute_id", "attribute_value") VALUES (NULL, 13, 12, '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_level_name, catalog_level_number FROM catalog_structure WHERE (catalog_level_number > 5 OR catalog_level_number > 10) ORDER BY catalog_level_name, catalog_structure.catalog_level_number NULLS LAST;

/*
Gold Result:
('15', 6)
*/

-- Prediction Query
SELECT catalog_level_name, catalog_level_number FROM Catalog_Structure WHERE catalog_level_number BETWEEN 5 AND 10;

/*
Prediction Result:
('16', 5)
('15', 6)
*/