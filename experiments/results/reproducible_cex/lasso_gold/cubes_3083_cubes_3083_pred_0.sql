-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (1001, 'purpose', 'Patrick Sanchez', 1002.5, 1003.5);
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1001, 'Brian Yang', 1004.5, 1005.5, 'offer', 'Benin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "brand" FROM (SELECT "LHS"."id" AS "id", "LHS"."brand" AS "brand", "LHS"."name" AS "name", "LHS"."focal_length_mm" AS "focal_length_mm", "LHS"."max_aperture" AS "max_aperture", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country" FROM "camera_lens" AS "LHS" INNER JOIN (SELECT * FROM (SELECT * FROM "mountain" WHERE ("range" <> 'Toubkal Atlas' AND "range" <> 'Lasta Massif')) AS LHS WHERE NOT EXISTS(SELECT 1 FROM photos AS RHS WHERE (LHS.id = RHS.id))) AS RHS ON (LHS.id = RHS.id)) ORDER BY brand, "brand" NULLS LAST;

/*
Gold Result:
('purpose',)
*/

-- Prediction Query
SELECT T3.brand FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id JOIN camera_lens AS T3 ON T2.camera_lens_id = T3.id WHERE T1.range = 'Toubkal Atlas' INTERSECT SELECT T3.brand FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id JOIN camera_lens AS T3 ON T2.camera_lens_id = T3.id WHERE T1.range = 'Lasta Massif';

/*
Prediction Result:
*/