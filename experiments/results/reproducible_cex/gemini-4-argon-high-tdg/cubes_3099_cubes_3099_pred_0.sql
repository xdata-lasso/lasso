-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (1, 'Color', 'TEXT');
INSERT INTO Attribute_Definitions (attribute_id, attribute_name, attribute_data_type) VALUES (2, 'Waterproof', 'BOOLEAN');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (1, 'Outdoor Gear 2023', 'Summit Publishing', '2023-01-15 00:00:00', '2023-06-01 00:00:00');
INSERT INTO Catalogs (catalog_id, catalog_name, catalog_publisher, date_of_publication, date_of_latest_revision) VALUES (2, 'Winter Apparel', 'Peak Media', '2022-09-10 00:00:00', '2023-02-20 00:00:00');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (10, 1, 'Camping');
INSERT INTO Catalog_Structure (catalog_level_number, catalog_id, catalog_level_name) VALUES (20, 2, 'Jackets');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (1, 10, NULL, NULL, 2, 'Zebra Tent', 'STK-900', 250.0, 230.0, 200.0, '4 Person', '240cm', '130cm', '210cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (2, 10, 1, 1, 3, 'Alpha Sleeping Bag', 'STK-100', 120.0, 110.0, 95.0, '1 Person', '200cm', '30cm', '80cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (3, 20, 1, 2, 4, 'Alpha Sleeping Bag', 'STK-101', 140.0, 130.0, 115.0, '1 Person XL', '220cm', '35cm', '85cm');
INSERT INTO Catalog_Contents (catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, length, height, width) VALUES (4, 20, NULL, 3, NULL, 'Middle Lantern', 'STK-500', 45.0, 42.0, 38.0, '500 Lumens', '15cm', '25cm', '15cm');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 1, 1, 'Green');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 1, 2, 'True');
INSERT INTO Catalog_Contents_Additional_Attributes (catalog_level_number, catalog_entry_id, attribute_id, attribute_value) VALUES (10, 2, 1, 'Blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY catalog_entry_name, catalog_contents.catalog_entry_id NULLS LAST;

/*
Gold Result:
('Alpha Sleeping Bag',)
('Alpha Sleeping Bag',)
('Middle Lantern',)
('Zebra Tent',)
*/

-- Prediction Query
SELECT DISTINCT (catalog_entry_name) FROM catalog_contents;

/*
Prediction Result:
('Zebra Tent',)
('Alpha Sleeping Bag',)
('Middle Lantern',)
*/