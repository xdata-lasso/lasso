-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, NULL, 'default1', 1.0, NULL);
INSERT INTO mountain (id, name, height, prominence, range, country) VALUES (1, 'default2', 0.0, 0.0, NULL, NULL), (0, 'default1', NULL, 0.0, 'default2', NULL), (2, NULL, 1.0, NULL, NULL, 'default1'), (3, 'default2', 1.0, 1.0, 'default2', NULL);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 3, 1, NULL, NULL), (0, 3, NULL, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, color, name FROM photos ORDER BY id;

/*
Gold Result:
(0, 'default2', 'default1')
(1, None, None)
*/

-- Prediction Query
SELECT id, color, name FROM photos;

/*
Prediction Result:
(0, 'default2', 'default1')
(1, None, None)
*/