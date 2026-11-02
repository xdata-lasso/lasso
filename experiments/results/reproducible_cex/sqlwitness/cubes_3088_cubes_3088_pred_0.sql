-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (0, 'default2', 'Olympus', NULL, 0.0), (1, 'default1', NULL, NULL, NULL), (2, 'Sigma', NULL, NULL, 1.0), (3, 'Sigma', NULL, 1.0, NULL), (4, NULL, 'default1', 1.0, NULL), (5, 'Sigma', 'Olympus', 1.0, NULL), (6, NULL, 'default2', 0.0, 0.0), (7, 'default2', 'default1', 1.0, 0.0), (8, 'Olympus', 'Sigma', NULL, NULL), (9, 'Olympus', 'default2', 0.0, 1.0), (10, 'Sigma', 'default2', NULL, 1.0), (11, 'Olympus', 'default2', 0.0, NULL);
INSERT INTO mountain (id, name, height, prominence, range, country) VALUES (0, 'Sigma', NULL, NULL, 'default1', 'Sigma');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (0, NULL, 10, NULL, NULL), (1, 0, 8, 'default2', 'Olympus');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."id" AS "id_other", "RHS"."mountain_id" AS "mountain_id", "RHS"."color" AS "color", "RHS"."name" AS "name_other" FROM (SELECT * FROM "camera_lens" WHERE ("brand" = 'Sigma' OR "brand" = 'Olympus')) AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Sigma',)
('default2',)
*/

-- Prediction Query
SELECT T1.name FROM camera_lens AS T1 JOIN photos AS T2 ON T2.camera_lens_id = T1.id WHERE T1.brand = 'Sigma' OR T1.brand = 'Olympus';

/*
Prediction Result:
('default2',)
('Sigma',)
*/