-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by brand ASC, then id ASC, where id order and name order diverge, and checks against SELECT DISTINCT or INNER JOIN photos mutations.
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Nikon', 'Nikkor 50mm', 50.0, 1.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Canon', 'EF 85mm', 85.0, 1.4);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (3, 'Canon', 'EF 24mm', 24.0, 2.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (4, 'Canon', 'EF 24mm', 24.0, 1.4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT brand, name FROM camera_lens ORDER BY brand, camera_lens.id NULLS LAST;

/*
Gold Result:
('Canon', 'EF 85mm')
('Canon', 'EF 24mm')
('Canon', 'EF 24mm')
('Nikon', 'Nikkor 50mm')
*/

-- Prediction Query
SELECT brand, name FROM camera_lens ORDER BY max_aperture DESC, camera_lens.id NULLS LAST;

/*
Prediction Result:
('Canon', 'EF 24mm')
('Nikon', 'Nikkor 50mm')
('Canon', 'EF 85mm')
('Canon', 'EF 24mm')
*/