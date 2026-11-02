-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mount Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Toubkal', 4167.0, 3755.0, 'Toubkal Atlas', 'Morocco');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Abune Yosef', 4260.0, 1909.0, 'Lasta Massif', 'Ethiopia');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Mystery Peak', 3000.0, 1000.0, NULL, 'Unknown');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (5, 'K2', 8611.0, 4017.0, 'Karakoram', 'Pakistan');
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1, 'Canon', 'EF 50mm', 50.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (2, 'Nikon', 'AF-S 35mm', 35.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (3, 'Sony', 'FE 85mm', 85.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (4, 'Sigma', 'Art 24mm', 24.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (5, 'Zeiss', 'Batis 40mm', 40.0, 2.0);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (5, 2, 2, 'RGB', 'PhotoWithId5');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (10, 1, 1, 'RGB', 'PhotoOfMountain1');
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