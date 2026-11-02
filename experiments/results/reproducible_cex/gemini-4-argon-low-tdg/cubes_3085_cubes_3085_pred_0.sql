-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1, 'BrandA', 'PrimeLens', 35.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (2, 'BrandB', 'PrimeLens', 35.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (3, 'BrandC', 'PrimeLens', 50.0, 2.0);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (4, 'BrandD', 'ZoomLens', 70.0, 2.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (5, 'BrandE', NULL, 24.0, 2.8);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1, NULL, 1, 'C1', 'P1');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (2, NULL, 1, 'C1', 'P2');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (3, NULL, 1, 'C2', 'P3');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (4, NULL, 2, 'C1', 'P4');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (5, NULL, 3, 'C1', 'P5');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (6, NULL, 4, 'C1', 'P6');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (7, NULL, 4, 'C2', 'P7');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (8, NULL, 5, 'C1', 'P8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.brand AS brand, LHS.name AS name, LHS.focal_length_mm AS focal_length_mm, LHS.max_aperture AS max_aperture, RHS.n AS n FROM camera_lens AS LHS INNER JOIN (SELECT camera_lens_id, COUNT(*) AS n FROM photos GROUP BY camera_lens_id) AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('PrimeLens', 1)
('PrimeLens', 1)
('PrimeLens', 3)
('ZoomLens', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM camera_lens AS T1 JOIN photos AS T2 ON T1.id = T2.camera_lens_id GROUP BY T1.id ORDER BY COUNT(*), T1.name NULLS LAST;

/*
Prediction Result:
('PrimeLens', 1)
('PrimeLens', 1)
(None, 1)
('ZoomLens', 2)
('PrimeLens', 3)
*/