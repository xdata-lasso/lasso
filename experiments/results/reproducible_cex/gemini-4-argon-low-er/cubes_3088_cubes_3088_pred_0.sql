-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Sigma', 'Lens B', 50.0, 1.4);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Olympus', 'Lens A', 35.0, 1.8);
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Mount X', 1000.0, 500.0, 'Range Y', 'Country Z');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'RGB', 'Photo 1');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (2, 1, 2, 'RGB', 'Photo 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."id" AS "id_other", "RHS"."mountain_id" AS "mountain_id", "RHS"."color" AS "color", "RHS"."name" AS "name_other" FROM (SELECT * FROM "camera_lens" WHERE ("brand" = 'Sigma' OR "brand" = 'Olympus')) AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Lens A',)
('Lens B',)
*/

-- Prediction Query
SELECT T1.name FROM camera_lens AS T1 JOIN photos AS T2 ON T2.camera_lens_id = T1.id WHERE T1.brand = 'Sigma' OR T1.brand = 'Olympus';

/*
Prediction Result:
('Lens B',)
('Lens A',)
*/