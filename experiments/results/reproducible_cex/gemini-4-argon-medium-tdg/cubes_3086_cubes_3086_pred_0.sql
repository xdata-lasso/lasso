-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mont Blanc', 4808.7, 4695.0, 'Alps', 'France');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Piz Bernina', 4048.6, 2234.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Exact FourK', 4000.0, 4000.0, 'TestRange', 'CountryA');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Just Under', 3999.9, 5000.0, 'TestRange', 'CountryB');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Null Height', NULL, 4500.0, 'TestRange', 'CountryC');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (6, 'No Photo High', 8848.86, 8848.86, 'Himalayas', 'Nepal');
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (10, 'Canon', 'EF 50mm', 50.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (20, 'Nikon', 'AF-S 24mm', 24.0, 1.4);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (101, 1, 10, 'Color', 'Blanc Sunrise');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (102, 1, 20, 'BW', 'Blanc Sunset');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (103, 2, 10, 'Color', 'Bernina Peak');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (104, 3, 10, 'Color', 'Exact Shot');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (105, 4, 20, 'Color', 'Under Shot');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (106, 5, 10, 'BW', 'Null Shot');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (107, NULL, 10, 'Color', 'Orphan Photo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM (SELECT id, name, height, prominence, RANGE, country, id_other, camera_lens_id, color, name_other, id AS mountain_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.id AS id_other, RHS.camera_lens_id AS camera_lens_id, RHS.color AS color, RHS.name AS name_other FROM mountain AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.mountain_id))) WHERE (height >= 4000.0) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(1, 'Mont Blanc')
(1, 'Mont Blanc')
(2, 'Piz Bernina')
(3, 'Exact FourK')
*/

-- Prediction Query
SELECT T1.id, T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id WHERE T1.height > 4000;

/*
Prediction Result:
(1, 'Mont Blanc')
(1, 'Mont Blanc')
(2, 'Piz Bernina')
*/