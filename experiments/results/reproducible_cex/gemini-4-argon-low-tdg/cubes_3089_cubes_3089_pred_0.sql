-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (Range DESC, id ASC), ties in Range, ties in projected columns (DISTINCT vs ALL), NULL values in Range and projected columns, and foreign key join discrepancies (mountains with 0, 1, and multiple photos).
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Everest', 8848.86, 8848.86, 'Himalayas', 'Nepal');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (2, 'K2', 8611.0, 4020.0, 'Karakoram', 'Pakistan');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (3, 'Kangchenjunga', 8586.0, 3922.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (4, 'TwinPeak', 5000.0, 1500.0, 'Alps', 'Switzerland');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (5, 'TwinPeak', 5000.0, 1500.0, 'Alps', 'France');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (6, 'MysteryMtn', NULL, 2000.0, NULL, 'Unknown');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (7, 'ShadowPeak', 4000.0, NULL, NULL, NULL);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Canon', 'EF 50mm', 50.0, 1.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Nikon', 'AF-S 24-70mm', 24.0, 2.8);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'Color', 'Everest Sunrise');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (2, 1, 2, 'BW', 'Everest North Face');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (3, 2, 1, 'Color', 'K2 Summit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, height, prominence FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY RANGE DESC, mountain.id NULLS LAST) LIMIT 21);

/*
Gold Result:
('K2', 8611.0, 4020.0)
('Everest', 8848.86, 8848.86)
('Kangchenjunga', 8586.0, 3922.0)
('TwinPeak', 5000.0, 1500.0)
('TwinPeak', 5000.0, 1500.0)
('MysteryMtn', None, 2000.0)
('ShadowPeak', 4000.0, None)
*/

-- Prediction Query
SELECT name, height, prominence FROM mountain WHERE RANGE <> 'Aberdare Range';

/*
Prediction Result:
('Everest', 8848.86, 8848.86)
('K2', 8611.0, 4020.0)
('Kangchenjunga', 8586.0, 3922.0)
('TwinPeak', 5000.0, 1500.0)
('TwinPeak', 5000.0, 1500.0)
*/