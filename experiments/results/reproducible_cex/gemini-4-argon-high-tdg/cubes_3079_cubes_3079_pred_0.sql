-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Morocco', 3000.0, 1500.0, 'Atlas', 'Algeria');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (2, 'Tahat', 2908.0, 2328.0, 'Morocco', 'Algeria');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (3, 'Jbel Ayachi', 3757.0, 1400.0, 'High Atlas', 'morocco');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (4, 'Teide', 3715.0, 3715.0, 'Canary', 'Spain');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Sony', 'FE 35mm', 35.0, 1.4);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'RGB', 'Desert Peak');
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