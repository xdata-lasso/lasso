-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Mount Everest', 8848.86, 8848.86, 'Mahalangur Himalaya', 'Nepal');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (2, 'K2', 8611.0, 4020.0, 'Baltoro Karakoram', 'Pakistan');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (5, 'Zeiss', 'Otus 55mm', 55.0, 1.4);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (10, 'Nikon', 'Nikkor L3', 50.0, 2.0);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (15, 'Canon', 'EF 70-200mm', 200.0, 2.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (20, 'Nikon', 'Nikkor L1', 85.0, 1.4);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (25, 'Canon', 'EF 24-70mm', 70.0, 4.0);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (30, 'Nikon', 'Nikkor L4', 24.0, 4.0);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (40, 'Nikon', 'Nikkor L2', 35.0, 2.8);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 15, 'Color', 'Sunrise Peak');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (2, 2, 15, 'B&W', 'Winter Ridge');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (3, 1, 20, 'Color', 'Base Camp View');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT brand, name FROM camera_lens ORDER BY brand, camera_lens.id NULLS LAST;

/*
Gold Result:
('Canon', 'EF 70-200mm')
('Canon', 'EF 24-70mm')
('Nikon', 'Nikkor L3')
('Nikon', 'Nikkor L1')
('Nikon', 'Nikkor L4')
('Nikon', 'Nikkor L2')
('Zeiss', 'Otus 55mm')
*/

-- Prediction Query
SELECT brand, name FROM camera_lens ORDER BY max_aperture DESC, camera_lens.id NULLS LAST;

/*
Prediction Result:
('Canon', 'EF 24-70mm')
('Nikon', 'Nikkor L4')
('Canon', 'EF 70-200mm')
('Nikon', 'Nikkor L2')
('Nikon', 'Nikkor L3')
('Zeiss', 'Otus 55mm')
('Nikon', 'Nikkor L1')
*/