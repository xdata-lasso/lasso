-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (1, 'Mount Alpha', 4500.5, 1200.0, 'Zeta Range', 'CountryA');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (2, 'Mount Beta', 4400.0, 1100.5, 'Ypsilon Range', 'CountryA');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (3, 'Mount Gamma', 4300.2, 1050.0, 'Xi Range', 'CountryB');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (4, 'Mount Delta', 4200.8, 980.0, 'Winters Range', 'CountryB');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (5, 'Mount Epsilon', 4100.0, 920.3, 'Victor Range', 'CountryC');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (6, 'Mount Zeta', 4000.1, 890.0, 'Uniform Range', 'CountryC');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (7, 'Mount Eta', 3950.0, 850.5, 'Tango Range', 'CountryD');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (8, 'Mount Theta', 3900.4, 810.0, 'Sierra Range', 'CountryD');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (9, 'Mount Iota', 3850.0, 790.2, 'Romeo Range', 'CountryE');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (10, 'Mount Kappa', 3800.7, 750.0, 'Quebec Range', 'CountryE');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (11, 'Mount Lambda', 3750.0, 720.8, 'Papa Range', 'CountryF');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (12, 'Mount Mu', 3700.3, 690.0, 'Oscar Range', 'CountryF');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (13, 'Mount Nu', 3650.0, 660.4, 'November Range', 'CountryG');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (14, 'Mount Xi', 3600.9, 630.0, 'Mike Range', 'CountryG');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (15, 'Mount Omicron', 3550.0, 600.1, 'Lima Range', 'CountryH');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (16, 'Mount Pi', 3500.6, 570.0, 'Kilo Range', 'CountryH');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (17, 'Mount Rho', 3450.0, 540.9, 'Juliet Range', 'CountryI');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (18, 'Mount Sigma', 3400.2, 510.0, 'India Range', 'CountryI');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (19, 'Mount Tau', 3350.0, 480.7, 'Hotel Range', 'CountryJ');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (25, 'Mount Cutoff Late', 3300.5, 450.0, 'Golf Range', 'CountryJ');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (20, 'Mount Cutoff Early', 3250.0, 420.3, 'Golf Range', 'CountryK');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (22, 'Mount Cutoff Mid', 3200.8, 390.0, 'Golf Range', 'CountryK');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (21, 'Mount Foxtrot', 3150.0, 360.6, 'Foxtrot Range', 'CountryL');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (23, 'Mount Echo', 3100.4, 330.0, 'Echo Range', 'CountryL');
INSERT INTO mountain (id, name, Height, Prominence, Range, Country) VALUES (24, 'Mount Bravo', 3050.0, 300.2, 'Bravo Range', 'CountryM');
INSERT INTO camera_lens (id, brand, name, focal_length_mm, max_aperture) VALUES (1, 'Canon', 'EF 50mm', 50.0, 1.8);
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (1, 1, 1, 'RGB', 'Alpha Shot 1');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (2, 1, 1, 'BW', 'Alpha Shot 2');
INSERT INTO photos (id, mountain_id, camera_lens_id, color, name) VALUES (3, 24, 1, 'RGB', 'Bravo Shot');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, height, prominence FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY RANGE DESC, mountain.id NULLS LAST) LIMIT 21);

/*
Gold Result:
('Mount Alpha', 4500.5, 1200.0)
('Mount Beta', 4400.0, 1100.5)
('Mount Gamma', 4300.2, 1050.0)
('Mount Delta', 4200.8, 980.0)
('Mount Epsilon', 4100.0, 920.3)
('Mount Zeta', 4000.1, 890.0)
('Mount Eta', 3950.0, 850.5)
('Mount Theta', 3900.4, 810.0)
('Mount Iota', 3850.0, 790.2)
('Mount Kappa', 3800.7, 750.0)
('Mount Lambda', 3750.0, 720.8)
('Mount Mu', 3700.3, 690.0)
('Mount Nu', 3650.0, 660.4)
('Mount Xi', 3600.9, 630.0)
('Mount Omicron', 3550.0, 600.1)
('Mount Pi', 3500.6, 570.0)
('Mount Rho', 3450.0, 540.9)
('Mount Sigma', 3400.2, 510.0)
('Mount Tau', 3350.0, 480.7)
('Mount Cutoff Early', 3250.0, 420.3)
('Mount Cutoff Mid', 3200.8, 390.0)
*/

-- Prediction Query
SELECT name, height, prominence FROM mountain WHERE RANGE <> 'Aberdare Range';

/*
Prediction Result:
('Mount Alpha', 4500.5, 1200.0)
('Mount Beta', 4400.0, 1100.5)
('Mount Gamma', 4300.2, 1050.0)
('Mount Delta', 4200.8, 980.0)
('Mount Epsilon', 4100.0, 920.3)
('Mount Zeta', 4000.1, 890.0)
('Mount Eta', 3950.0, 850.5)
('Mount Theta', 3900.4, 810.0)
('Mount Iota', 3850.0, 790.2)
('Mount Kappa', 3800.7, 750.0)
('Mount Lambda', 3750.0, 720.8)
('Mount Mu', 3700.3, 690.0)
('Mount Nu', 3650.0, 660.4)
('Mount Xi', 3600.9, 630.0)
('Mount Omicron', 3550.0, 600.1)
('Mount Pi', 3500.6, 570.0)
('Mount Rho', 3450.0, 540.9)
('Mount Sigma', 3400.2, 510.0)
('Mount Tau', 3350.0, 480.7)
('Mount Cutoff Early', 3250.0, 420.3)
('Mount Foxtrot', 3150.0, 360.6)
('Mount Cutoff Mid', 3200.8, 390.0)
('Mount Echo', 3100.4, 330.0)
('Mount Bravo', 3050.0, 300.2)
('Mount Cutoff Late', 3300.5, 450.0)
*/