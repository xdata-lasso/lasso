-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1026, 'Morocco', 1027.5, 1028.5, 'knowledge', 'Qatar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanprominence" AS "avg_prominence_" FROM (SELECT "country", AVG("prominence") AS "meanprominence" FROM (SELECT * FROM "mountain" WHERE ("country" = 'Morocco')) GROUP BY country) ORDER BY avg_prominence_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(prominence) FROM mountain WHERE country = 'Morocco';

/*
Prediction Result:
(None,)
*/