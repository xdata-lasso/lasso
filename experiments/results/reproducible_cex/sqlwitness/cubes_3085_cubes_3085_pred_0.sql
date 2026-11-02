-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, NULL, 'default1', NULL, 1.0), (0, 'default2', NULL, NULL, 1.0), (2, 'default1', 'default1', NULL, NULL);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (0, NULL, NULL, 'default1', 'default2'), (1, NULL, 2, 'default2', 'default1'), (2, NULL, 2, NULL, NULL), (3, NULL, 2, 'default1', 'default2'), (4, NULL, 1, 'default2', 'default2'), (5, NULL, 0, 'default1', 'default1'), (6, NULL, 2, 'default2', 'default2'), (7, NULL, NULL, 'default1', NULL), (8, NULL, 2, 'default1', NULL), (9, NULL, 0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.brand AS brand, LHS.name AS name, LHS.focal_length_mm AS focal_length_mm, LHS.max_aperture AS max_aperture, RHS.n AS n FROM camera_lens AS LHS INNER JOIN (SELECT camera_lens_id, COUNT(*) AS n FROM photos GROUP BY camera_lens_id) AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
('default1', 1)
('default1', 5)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM camera_lens AS T1 JOIN photos AS T2 ON T1.id = T2.camera_lens_id GROUP BY T1.id ORDER BY COUNT(*), T1.name NULLS LAST;

/*
Prediction Result:
('default1', 1)
(None, 2)
('default1', 5)
*/