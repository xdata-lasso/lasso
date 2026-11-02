-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (1, 'Width_Text', 'Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (2, 'Color_Text', 'Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (3, 'Count_A', 'Int');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (4, 'Count_B', 'Int');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (5, 'Count_C', 'Int');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (6, 'Flag_1', 'Boolean');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (7, 'Flag_2', 'Boolean');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (8, 'Flag_3', 'Boolean');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (9, 'Flag_4', 'Boolean');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (10, 'Created_On', 'Date');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (11, 'Weight_1', 'Real');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (12, 'Weight_2', 'Real');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (13, 'Weight_3', 'Real');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (14, 'Weight_4', 'Real');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (15, 'Weight_5', 'Real');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Main Catalog', 'Acme Corp', '2023-01-01 00:00:00', '2023-06-01 00:00:00');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (1, 1, 'Category');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (100, 1, NULL, NULL, NULL, 'Widget', 'STK-100', 10.0, 9.0, 8.0, '10L', '5cm', '5cm', '5cm');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (1, 100, 1, 'Val1');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (1, 100, 1, 'Val2');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (1, 100, 2, 'Val3');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (1, 100, 3, '10');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (1, 100, 4, '20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attribute_data_type FROM (SELECT attribute_data_type, COUNT(*) AS n FROM attribute_definitions GROUP BY attribute_data_type) WHERE (n <> 3) ORDER BY attribute_data_type;

/*
Gold Result:
('Boolean',)
('Date',)
('Real',)
('Text',)
*/

-- Prediction Query
SELECT attribute_data_type FROM Attribute_Definitions GROUP BY attribute_data_type HAVING COUNT(*) > 3;

/*
Prediction Result:
('Boolean',)
('Real',)
*/