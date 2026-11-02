-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (8, '11', NULL, 12, '13', '14');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (7, '944', 944, 944, '944', '944');
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (10, '944', '944', 944, 944);
INSERT INTO "camera_lens" ("id", "brand", "name", "focal_length_mm", "max_aperture") VALUES (9, '944', '944', 944, 944);
INSERT INTO "photos" ("id", "mountain_id", "camera_lens_id", "color", "name") VALUES (944, 7, 10, '944', '944');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT maxheight AS max_height_, AVG(height) OVER () AS avg_height_ FROM (SELECT id, name, height, prominence, RANGE, country, MAX(height) OVER () AS maxheight FROM mountain) ORDER BY max_height_, avg_height_ NULLS LAST;

/*
Gold Result:
(944.0, 944.0)
*/

-- Prediction Query
SELECT MAX(height), AVG(height) FROM mountain;

/*
Prediction Result:
(944.0, 944.0)
*/