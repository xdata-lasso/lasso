-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturer --
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1, 1.0, 'man_279850', NULL, 10);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (2, 1.0, 'man_279850', NULL, 10);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (3, 1.0, 'man_279850', NULL, 10);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (4, 582.588439, '5k5swwqcgsk', -1, 0);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (5, 572.766956, '8c4p', 0, 10);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (6, 935.695299, 'u7vfe4hria2y', 7729, 7729);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (7, 797.015047, 'uzhs', 7719, 0);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (8, 582.588439, NULL, NULL, 10);

INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (9, NULL, '5k5swwqcgsk', NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_year FROM manufacturer WHERE (num_of_shops >= 10 OR num_of_shops > num_of_factories) ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
(None, 582.588439)
('5k5swwqcgsk', 582.588439)
('5k5swwqcgsk', None)
('8c4p', 572.766956)
('man_279850', 1.0)
('man_279850', 1.0)
('man_279850', 1.0)
('u7vfe4hria2y', 935.695299)
*/

-- Prediction Query
SELECT name, open_year FROM manufacturer WHERE num_of_shops > 10 OR Num_of_Factories < 10;

/*
Prediction Result:
('5k5swwqcgsk', 582.588439)
('8c4p', 572.766956)
('u7vfe4hria2y', 935.695299)
*/