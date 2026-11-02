-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Ras Dashen', 4550.0, 3997.0, 'Simien', 'Ethiopia');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Canon', 'Lens1', 50.0, 1.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Nikon', 'Lens2', 35.0, 1.4);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'Color', 'Photo1');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (2, 1, 2, 'Color', 'Photo2');
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