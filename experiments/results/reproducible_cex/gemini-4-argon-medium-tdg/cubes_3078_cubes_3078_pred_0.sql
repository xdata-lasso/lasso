-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Ras Dashen', 4550.0, 3997.0, 'Simien', 'Ethiopia');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Tullu Demtu', 4377.0, 2527.0, 'Bale', 'Ethiopia');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Mount Kenya', 5199.0, 3825.0, 'East African', 'Kenya');
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (10, 'Canon', 'EF 50mm', 50.0, 1.8);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (20, 'Nikon', 'AF-S 35mm', 35.0, 1.4);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (2, 1, 10, 'Color', 'Photo A');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (3, 1, 10, 'BW', 'Photo B');
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (4, 1, 20, 'Color', 'Photo C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count_distinct_t2_camera_lens_id_" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."height" AS "height", "LHS"."prominence" AS "prominence", "LHS"."range" AS "range", "LHS"."country" AS "country", "RHS"."camera_lens_id" AS "camera_lens_id", "RHS"."n" AS "n" FROM (SELECT * FROM "mountain" WHERE ("country" = 'Ethiopia')) AS LHS INNER JOIN (SELECT camera_lens_id, id, COUNT(*) AS n FROM photos GROUP BY camera_lens_id, id) AS RHS ON (LHS.id = RHS.id)) ORDER BY count_distinct_t2_camera_lens_id_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.camera_lens_id) FROM mountain AS T1 JOIN photos AS T2 ON T1.id = T2.mountain_id WHERE T1.country = 'Ethiopia';

/*
Prediction Result:
(2,)
*/