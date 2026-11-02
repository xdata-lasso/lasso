-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join on ID, range exclusions ('Toubkal Atlas', 'Lasta Massif', NULL), and NOT EXISTS on photos.id = mountain.id.
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (1, 'M1', 1000.0, 100.0, 'Alps', 'France');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (2, 'M2', 2000.0, 200.0, 'Toubkal Atlas', 'Morocco');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (3, 'M3', 3000.0, 300.0, 'Lasta Massif', 'Ethiopia');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (4, 'M4', 4000.0, 400.0, 'Andes', 'Peru');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (5, 'M5', 5000.0, 500.0, NULL, 'Nowhere');
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1, 'Canon', 'L1', 50.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (2, 'Nikon', 'L2', 35.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (3, 'Sony', 'L3', 85.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (4, 'Fuji', 'L4', 24.0, 2.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (5, 'Leica', 'L5', 50.0, 1.2);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (4, 1, 1, 'RGB', 'P4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "brand" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country" FROM "camera_lens" AS "LHS" INNER JOIN (SELECT * FROM (SELECT * FROM "mountain" WHERE ("range" <> 'Toubkal Atlas' AND "range" <> 'Lasta Massif')) AS LHS WHERE NOT EXISTS(SELECT 1 FROM photos AS RHS WHERE (LHS.id = RHS.id))) AS RHS ON (LHS.id = RHS.id)) ORDER BY brand, "brand" NULLS LAST;

/*
Gold Result:
('Canon',)
*/

-- Prediction Query
SELECT T3.brand FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id JOIN camera_lens AS T3 ON T2.camera_lens_id = T3.id WHERE T1.range = 'Toubkal Atlas' INTERSECT SELECT T3.brand FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id JOIN camera_lens AS T3 ON T2.camera_lens_id = T3.id WHERE T1.range = 'Lasta Massif';

/*
Prediction Result:
*/