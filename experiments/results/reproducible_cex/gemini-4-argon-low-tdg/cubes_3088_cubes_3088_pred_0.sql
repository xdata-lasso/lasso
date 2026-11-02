-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1, 'Sigma', 'Zeta Lens', 85.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (2, 'Olympus', NULL, 25.0, 1.2);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (3, 'Sigma', 'Alpha Lens', 24.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (4, NULL, 'Null Brand Lens', 50.0, 2.0);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (1, NULL, 1, 'Color', 'A_Photo');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (2, NULL, 2, 'Color', 'M_Photo');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (3, NULL, 3, 'Color', 'Z_Photo');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (4, NULL, 4, 'Color', 'N_Photo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."id" AS "id_other", "RHS"."mountain_id" AS "mountain_id", "RHS"."color" AS "color", "RHS"."name" AS "name_other" FROM (SELECT * FROM "camera_lens" WHERE ("brand" = 'Sigma' OR "brand" = 'Olympus')) AS LHS INNER JOIN photos AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Lens',)
('Zeta Lens',)
*/

-- Prediction Query
SELECT T1.name FROM camera_lens AS T1 JOIN photos AS T2 ON T2.camera_lens_id = T1.id WHERE T1.brand = 'Sigma' OR T1.brand = 'Olympus';

/*
Prediction Result:
('Zeta Lens',)
(None,)
('Alpha Lens',)
*/