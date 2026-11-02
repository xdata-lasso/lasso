-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Attribute_Definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (29, '39', '39');
INSERT INTO "Attribute_Definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (28, '39', '39');
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (31, '39', '39', 39, 39);
INSERT INTO "Catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (30, '39', '39', 39, 39);
INSERT INTO "Catalog_Structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (37, 30, '39');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (39, 37, 38, 39, 40, NULL, '36', 41, 42, 43, '44', '45', '46', '47');
INSERT INTO "Catalog_Contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (32, 37, 39, NULL, 39, NULL, NULL, 39, 39, 39, '39', '39', '39', '39');
INSERT INTO "Catalog_Contents_Additional_Attributes" ("catalog_level_number", "catalog_entry_id", "attribute_id", "attribute_value") VALUES (37, 32, 39, '39');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.height AS height_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.previous_entry_id = RHS.catalog_entry_id AND LHS.product_stock_number = RHS.product_stock_number)) ORDER BY catalog_entry_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY price_in_dollars DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/