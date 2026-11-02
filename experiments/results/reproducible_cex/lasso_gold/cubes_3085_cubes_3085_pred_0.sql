-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1008, 'mouth', 'Kristina Baldwin', 1009.5, 1010.5);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1015, NULL, 'Daniel Gallagher', 1016.5, 1017.5);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1028, 'win', 'Juan Calderon', 1022.5, 1023.5);
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1011, 'Jennifer Cole', 1012.5, 1013.5, 'fall', 'Sudan');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1018, 'James Howard', 1019.5, 1020.5, 'guy', 'Netherlands');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1024, 'Shannon Ray', 1025.5, 1026.5, 'sea', 'Bangladesh');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1014, 1011, 1008, 'true', 'Robert Wolfe');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1021, 1018, 1015, 'everything', 'Monica Herrera');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1027, 1024, 1015, 'answer', 'Patricia Galloway');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.brand AS brand, LHS.name AS name, LHS.focal_length_mm AS focal_length_mm, LHS.max_aperture AS max_aperture, RHS.n AS n FROM camera_lens AS LHS INNER JOIN (SELECT camera_lens_id, COUNT(*) AS n FROM photos GROUP BY camera_lens_id) AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Daniel Gallagher', 2)
('Kristina Baldwin', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM camera_lens AS T1 JOIN photos AS T2 ON T1.id = T2.camera_lens_id GROUP BY T1.id ORDER BY COUNT(*), T1.name NULLS LAST;

/*
Prediction Result:
('Kristina Baldwin', 1)
('Daniel Gallagher', 2)
*/