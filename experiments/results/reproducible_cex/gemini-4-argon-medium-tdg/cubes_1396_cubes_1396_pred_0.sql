-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests composite grouping: catches mutants that only GROUP BY accreditation_level (missing accreditation_type) or only GROUP BY accreditation_type.
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('ChipA', 2021.0, 2048.0, 32768.0, '2', 'No', '4.2');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (2.0, '40x25', '1280x720', 65536.0, 2000.0, 'MapB', 'LCD');
-- 'Level_Split' has 4 rows total, but split across 'Type_X' (2 rows) and 'Type_Y' (2 rows).
-- Neither pair exceeds 3. A mutant grouping only by accreditation_level will falsely return 'Level_Split'.
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P1', 'ChipA', '2.0', 'CompA', 'Type_X', 'Level_Split', '2022-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P2', 'ChipA', '2.0', 'CompA', 'Type_X', 'Level_Split', '2022-01-02');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P3', 'ChipA', '2.0', 'CompA', 'Type_Y', 'Level_Split', '2022-01-03');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P4', 'ChipA', '2.0', 'CompA', 'Type_Y', 'Level_Split', '2022-01-04');
-- 'Type_Shared' has 4 rows total, but split across 'Level_1' (2 rows) and 'Level_2' (2 rows).
-- Catches mutants that group only by accreditation_type.
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P5', 'ChipA', '2.0', 'CompB', 'Type_Shared', 'Level_1', '2022-01-05');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P6', 'ChipA', '2.0', 'CompB', 'Type_Shared', 'Level_1', '2022-01-06');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P7', 'ChipA', '2.0', 'CompB', 'Type_Shared', 'Level_2', '2022-01-07');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P8', 'ChipA', '2.0', 'CompB', 'Type_Shared', 'Level_2', '2022-01-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT accreditation_level FROM (SELECT accreditation_level, accreditation_type, COUNT(*) AS n FROM phone GROUP BY accreditation_level, accreditation_type) WHERE (n > 3) ORDER BY accreditation_level;

/*
Gold Result:
*/

-- Prediction Query
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING COUNT(*) > 3;

/*
Prediction Result:
('Level_Split',)
*/