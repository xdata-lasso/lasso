-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Canon', 'Lens A', 50.0, 1.4);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Nikon', 'Lens B', 35.0, 2.8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT brand, name FROM camera_lens ORDER BY brand, camera_lens.id NULLS LAST;

/*
Gold Result:
('Canon', 'Lens A')
('Nikon', 'Lens B')
*/

-- Prediction Query
SELECT brand, name FROM camera_lens ORDER BY max_aperture DESC, camera_lens.id NULLS LAST;

/*
Prediction Result:
('Nikon', 'Lens B')
('Canon', 'Lens A')
*/