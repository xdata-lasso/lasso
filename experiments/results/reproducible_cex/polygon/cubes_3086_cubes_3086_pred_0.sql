-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (37, '35', 4001, 20, '21', '22');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (34, '36', 4000, NULL, NULL, NULL);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (15, '37', '37', 37, 37);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (24, '37', '37', 37, 37);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (23, 37, 24, '25', '26');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (30, 34, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM (SELECT id, name, height, prominence, RANGE, country, id_other, camera_lens_id, color, name_other, id AS mountain_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.id AS id_other, RHS.camera_lens_id AS camera_lens_id, RHS.color AS color, RHS.name AS name_other FROM mountain AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.mountain_id))) WHERE (height >= 4000.0) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(34, '36')
(37, '35')
*/

-- Prediction Query
SELECT T1.id, T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id WHERE T1.height > 4000;

/*
Prediction Result:
(37, '35')
*/