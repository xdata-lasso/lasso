-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "attribute_definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (1194, 'Cynthia Wilson', 'voice');
INSERT INTO "attribute_definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (1205, 'Cynthia Wilson', 'voice');
INSERT INTO "attribute_definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (1209, 'Angel Ellis', 'order');
INSERT INTO "attribute_definitions" ("attribute_id", "attribute_name", "attribute_data_type") VALUES (1219, 'Angel Ellis', 'order');
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1195, 'Lauren Williams', 'beat', '1996-05-04', '1997-06-05');
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1206, 'Lauren Williams', 'beat', '1996-05-04', '1997-06-05');
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1210, 'Angel Lewis MD', 'worker', '1998-07-06', '1970-08-07');
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (1220, 'Angel Lewis MD', 'worker', '1998-07-06', '1970-08-07');
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (1196, 1195, 'Kevin Mills');
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (1207, 1195, 'Kevin Mills');
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (1211, 1210, 'Benjamin Sanchez');
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (1221, 1210, 'Benjamin Sanchez');
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1197, 1196, 1198, 1199, 1200, 'Christina Moran', 'edge', 1201.5, 1202.5, 1203.5, 'Randyport', 'lot', 'four', 'woman');
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1208, 1196, 1198, 1199, 1200, 'Christina Moran', 'edge', 1201.5, 1202.5, 1203.5, 'Randyport', 'lot', 'four', 'woman');
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1212, 1211, 1213, 1214, 1215, 'Jeffrey Daniels', 'five', 1216.5, 1217.5, 1218.5, 'Lake Lisaport', 'work', 'record', 'body');
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1222, 1211, 1213, 1214, 1215, 'Jeffrey Daniels', 'five', 1216.5, 1217.5, 1218.5, 'Lake Lisaport', 'work', 'record', 'body');
INSERT INTO "catalog_contents_additional_attributes" ("catalog_level_number", "catalog_entry_id", "attribute_id", "attribute_value") VALUES (1196, 1197, 1194, '0');
INSERT INTO "catalog_contents_additional_attributes" ("catalog_level_number", "catalog_entry_id", "attribute_id", "attribute_value") VALUES (1211, 1212, 1209, '0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attribute_name, attribute_id FROM (SELECT LHS.attribute_id AS attribute_id, LHS.attribute_name AS attribute_name, LHS.attribute_data_type AS attribute_data_type, RHS.catalog_entry_id AS catalog_entry_id, RHS.catalog_level_number AS catalog_level_number, RHS.attribute_value AS attribute_value FROM attribute_definitions AS LHS LEFT JOIN catalog_contents_additional_attributes AS RHS ON (LHS.attribute_id = RHS.attribute_id)) WHERE (attribute_value = 0) ORDER BY attribute_name, attribute_id NULLS LAST;

/*
Gold Result:
('Angel Ellis', 1209)
('Cynthia Wilson', 1194)
*/

-- Prediction Query
SELECT t1.attribute_name, t1.attribute_id FROM Attribute_Definitions AS t1 JOIN Catalog_Contents_Additional_Attributes AS t2 ON t1.attribute_id = t2.attribute_id WHERE t2.attribute_value = 0;

/*
Prediction Result:
('Cynthia Wilson', 1194)
('Angel Ellis', 1209)
*/