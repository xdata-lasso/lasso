-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'France');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Aconcagua', 6961.0, 6961.0, 'Andes', 'Argentina');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Mount Elbert', 4401.0, 2772.0, 'Rockies', 'USA');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Toubkal', 4167.0, 3755.0, 'Toubkal Atlas', 'Morocco');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (6, 'Abune Yosef', 4260.0, 1909.0, 'Lasta Massif', 'Ethiopia');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (7, 'Mount Narodnaya', 1895.0, 1772.0, 'Urals', 'Russia');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (9, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1, 'Zeiss', 'Otus 55', 55.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (2, 'Canon', 'EF 50', 50.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (3, 'Canon', 'RF 85', 85.0, 1.2);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (4, NULL, 'Custom 35', 35.0, 2.0);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (5, 'Nikon', 'Nikkor 24', 24.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (6, 'Sony', 'FE 135', 135.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (7, 'Leica', 'Summilux 50', 50.0, 1.4);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (8, 'Fujifilm', 'XF 23', 23.0, 2.0);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (7, 1, 2, 'RGB', 'Ural Sunset');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "brand" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country" FROM "camera_lens" AS "LHS" INNER JOIN (SELECT * FROM (SELECT * FROM "mountain" WHERE ("range" <> 'Toubkal Atlas' AND "range" <> 'Lasta Massif')) AS LHS WHERE NOT EXISTS(SELECT 1 FROM photos AS RHS WHERE (LHS.id = RHS.id))) AS RHS ON (LHS.id = RHS.id)) ORDER BY brand, "brand" NULLS LAST;

/*
Gold Result:
(None,)
('Canon',)
('Canon',)
('Zeiss',)
*/

-- Prediction Query
SELECT T3.brand FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id JOIN camera_lens AS T3 ON T2.camera_lens_id = T3.id WHERE T1.range = 'Toubkal Atlas' INTERSECT SELECT T3.brand FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id JOIN camera_lens AS T3 ON T2.camera_lens_id = T3.id WHERE T1.range = 'Lasta Massif';

/*
Prediction Result:
*/