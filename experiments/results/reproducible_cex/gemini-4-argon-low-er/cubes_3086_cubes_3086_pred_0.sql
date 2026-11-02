-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Mount Test', 4000.0, 500.0, 'Test Range', 'Test Country');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Test Brand', 'Test Lens', 50.0, 1.8);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'Color', 'Test Photo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM (SELECT id, name, height, prominence, RANGE, country, id_other, camera_lens_id, color, name_other, id AS mountain_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.id AS id_other, RHS.camera_lens_id AS camera_lens_id, RHS.color AS color, RHS.name AS name_other FROM mountain AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.mountain_id))) WHERE (height >= 4000.0) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(1, 'Mount Test')
*/

-- Prediction Query
SELECT T1.id, T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id WHERE T1.height > 4000;

/*
Prediction Result:
*/