-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (101, 'Everest', 8848.86, 8848.86, 'Mahalangur Himalaya', 'Nepal');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (102, 'K2', 8611.0, 4020.0, 'Baltoro Karakoram', 'Pakistan');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Zeiss', 'Otus 85mm', 85.0, 1.4);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (2, 'Canon', 'EF 50mm', 50.0, 1.2);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (3, 'Yongnuo', 'EF 50mm', 50.0, 1.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (4, 'Nikon', 'Nikkor 24mm', 24.0, 2.8);
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (5, 'Leica', 'Summilux 35mm', 35.0, 1.4);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1001, 101, 1, 'RGB', 'Sunrise Peak');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1002, 101, 1, 'RGB', 'Ridge Line');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1003, 102, 1, 'BW', 'Stormy Summit');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1004, 101, 2, 'RGB', 'Base Camp');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1005, 102, 2, 'BW', 'Glacier Path');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1006, 102, 3, 'RGB', 'Alpenglow');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1007, 101, 4, 'RGB', 'Valley Mist 1');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1008, 101, 4, 'RGB', 'Valley Mist 2');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1009, 102, 4, 'BW', 'North Face 1');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1010, 102, 4, 'BW', 'North Face 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.brand AS brand, LHS.name AS name, LHS.focal_length_mm AS focal_length_mm, LHS.max_aperture AS max_aperture, RHS.n AS n FROM camera_lens AS LHS INNER JOIN (SELECT camera_lens_id, COUNT(*) AS n FROM photos GROUP BY camera_lens_id) AS RHS ON (LHS.id = RHS.camera_lens_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('EF 50mm', 1)
('EF 50mm', 2)
('Nikkor 24mm', 4)
('Otus 85mm', 3)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM camera_lens AS T1 JOIN photos AS T2 ON T1.id = T2.camera_lens_id GROUP BY T1.id ORDER BY COUNT(*), T1.name NULLS LAST;

/*
Prediction Result:
('EF 50mm', 1)
('EF 50mm', 2)
('Otus 85mm', 3)
('Nikkor 24mm', 4)
*/