-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests LIMIT 21 boundary (25 rows total), ORDER BY Range DESC, tie-breaking by id ASC, NULL values in Range, and column projection differentiation.
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (10, 'Mount Alpha', 8848.86, 8848.86, 'Zagro', 'CountryA');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Mount Beta', 8611.0, 4017.0, 'Zagro', 'CountryB');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (20, 'Mount Gamma', 8586.0, 3922.0, 'Zagro', 'CountryA');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mount Delta', 8516.0, 610.0, 'Urals', 'CountryC');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Mount Epsilon', 8485.0, 2378.0, 'Urals', 'CountryC');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Mount Zeta', 8188.0, 2340.0, 'Tatra', 'CountryD');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Mount Eta', 8167.0, 3357.0, 'Sierra', 'CountryE');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (6, 'Mount Theta', 8163.0, 3092.0, 'Rockies', 'CountryF');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (8, 'Mount Iota', 8125.0, 4608.0, 'Pyrenees', 'CountryG');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (7, 'Mount Kappa', 8091.0, 2984.0, 'Pyrenees', 'CountryG');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (9, 'Mount Lambda', 8080.0, 2155.0, 'Pamir', 'CountryH');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (11, 'Mount Mu', 8051.0, 1701.0, 'Olympus', 'CountryI');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (12, 'Mount Nu', 8035.0, 1524.0, 'Kunlun', 'CountryJ');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (15, 'Mount Xi', 8027.0, 2897.0, 'Karakoram', 'CountryK');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (14, 'Mount Omicron', 7952.0, 1800.0, 'Karakoram', 'CountryK');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (13, 'Mount Pi', 7937.0, 2239.0, 'Himalayas', 'CountryL');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (16, 'Mount Rho', 7893.0, 1620.0, 'Caucasus', 'CountryM');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (17, 'Mount Sigma', 7885.0, 2725.0, 'Carpathians', 'CountryN');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (18, 'Mount Tau', 7871.0, 1011.0, 'Balkans', 'CountryO');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (19, 'Mount Upsilon', 7861.0, 1650.0, 'Atlas', 'CountryP');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (22, 'Mount Phi', 7821.0, 1521.0, 'Andes', 'CountryQ');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (21, 'Mount Chi', 7816.0, 2295.0, 'Andes', 'CountryQ');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (23, 'Mount Psi', 7804.0, 504.0, 'Alps', 'CountryR');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (24, 'Mount Omega', 7795.0, 1095.0, 'Alaska', 'CountryS');
INSERT INTO "mountain" ("id", "name", "Height", "Prominence", "Range", "Country") VALUES (25, 'Mount NullRange', 7788.0, 3820.0, NULL, 'CountryT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, height, prominence FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY RANGE DESC, mountain.id NULLS LAST) LIMIT 21);

/*
Gold Result:
('Mount Beta', 8611.0, 4017.0)
('Mount Alpha', 8848.86, 8848.86)
('Mount Gamma', 8586.0, 3922.0)
('Mount Delta', 8516.0, 610.0)
('Mount Epsilon', 8485.0, 2378.0)
('Mount Zeta', 8188.0, 2340.0)
('Mount Eta', 8167.0, 3357.0)
('Mount Theta', 8163.0, 3092.0)
('Mount Kappa', 8091.0, 2984.0)
('Mount Iota', 8125.0, 4608.0)
('Mount Lambda', 8080.0, 2155.0)
('Mount Mu', 8051.0, 1701.0)
('Mount Nu', 8035.0, 1524.0)
('Mount Omicron', 7952.0, 1800.0)
('Mount Xi', 8027.0, 2897.0)
('Mount Pi', 7937.0, 2239.0)
('Mount Rho', 7893.0, 1620.0)
('Mount Sigma', 7885.0, 2725.0)
('Mount Tau', 7871.0, 1011.0)
('Mount Upsilon', 7861.0, 1650.0)
('Mount Chi', 7816.0, 2295.0)
*/

-- Prediction Query
SELECT name, height, prominence FROM mountain WHERE RANGE <> 'Aberdare Range';

/*
Prediction Result:
('Mount Delta', 8516.0, 610.0)
('Mount Epsilon', 8485.0, 2378.0)
('Mount Zeta', 8188.0, 2340.0)
('Mount Eta', 8167.0, 3357.0)
('Mount Beta', 8611.0, 4017.0)
('Mount Theta', 8163.0, 3092.0)
('Mount Kappa', 8091.0, 2984.0)
('Mount Iota', 8125.0, 4608.0)
('Mount Lambda', 8080.0, 2155.0)
('Mount Alpha', 8848.86, 8848.86)
('Mount Mu', 8051.0, 1701.0)
('Mount Nu', 8035.0, 1524.0)
('Mount Pi', 7937.0, 2239.0)
('Mount Omicron', 7952.0, 1800.0)
('Mount Xi', 8027.0, 2897.0)
('Mount Rho', 7893.0, 1620.0)
('Mount Sigma', 7885.0, 2725.0)
('Mount Tau', 7871.0, 1011.0)
('Mount Upsilon', 7861.0, 1650.0)
('Mount Gamma', 8586.0, 3922.0)
('Mount Chi', 7816.0, 2295.0)
('Mount Phi', 7821.0, 1521.0)
('Mount Psi', 7804.0, 504.0)
('Mount Omega', 7795.0, 1095.0)
*/