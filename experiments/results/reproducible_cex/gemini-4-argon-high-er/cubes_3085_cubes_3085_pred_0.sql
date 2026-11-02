-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'M1', 1000.0, 100.0, 'R1', 'C1');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Brand1', 'A', 50.0, 1.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Brand2', 'B', 35.0, 1.4);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'RGB', 'P1');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (2, 1, 1, 'RGB', 'P2');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (3, 1, 2, 'RGB', 'P3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.brand AS brand, LHS.name AS name, LHS.focal_length_mm AS focal_length_mm, LHS.max_aperture AS max_aperture, RHS.n AS n FROM camera_lens AS LHS INNER JOIN (SELECT camera_lens_id, COUNT(*) AS n FROM photos GROUP BY camera_lens_id) AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('A', 2)
('B', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM camera_lens AS T1 JOIN photos AS T2 ON T1.id = T2.camera_lens_id GROUP BY T1.id ORDER BY COUNT(*), T1.name NULLS LAST;

/*
Prediction Result:
('B', 1)
('A', 2)
*/