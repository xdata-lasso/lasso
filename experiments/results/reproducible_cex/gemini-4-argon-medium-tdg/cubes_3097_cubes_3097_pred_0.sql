-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (1, 'Weight', 'Z_Real');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (2, 'Length', 'M_Int');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (3, 'Width', 'M_Int');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (4, 'Color', 'B_Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (5, 'Size', 'B_Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (6, 'Material', 'B_Text');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (7, 'IsActive', 'A_Bool');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (8, 'InStock', 'A_Bool');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (9, 'IsFeatured', 'A_Bool');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (10, 'OnSale', 'A_Bool');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attribute_data_type FROM (SELECT attribute_data_type, COUNT(*) AS n FROM attribute_definitions GROUP BY attribute_data_type) WHERE (n <> 3) ORDER BY attribute_data_type;

/*
Gold Result:
('A_Bool',)
('M_Int',)
('Z_Real',)
*/

-- Prediction Query
SELECT attribute_data_type FROM Attribute_Definitions GROUP BY attribute_data_type HAVING COUNT(*) > 3;

/*
Prediction Result:
('A_Bool',)
*/