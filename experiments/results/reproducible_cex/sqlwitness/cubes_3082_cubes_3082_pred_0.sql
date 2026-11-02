-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'default1', 'default2', 1.0, NULL), (0, 'default1', 'default2', NULL, 0.0), (2, 'default2', 'default2', NULL, 0.0), (3, NULL, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT brand, name FROM camera_lens ORDER BY brand, camera_lens.id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default2')
('default1', 'default2')
('default2', 'default2')
*/

-- Prediction Query
SELECT brand, name FROM camera_lens ORDER BY max_aperture DESC, camera_lens.id NULLS LAST;

/*
Prediction Result:
('default1', 'default2')
('default2', 'default2')
('default1', 'default2')
(None, 'default1')
*/