-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic grouping, duplicate count outputs (SELECT DISTINCT vs SELECT), ordering (ASC vs DESC), and filtering out non-matching companies.
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('ChipA', 2020.0, 512.0, 1024.0, '1', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('ChipB', 2021.0, 1024.0, 2048.0, '2', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('ChipC', 2022.0, 2048.0, 4096.0, '2', 'Yes', 'Yes');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'A', 'Text');
-- ChipA for Nokia: count = 3 (inserted first to disrupt natural insertion order vs count order)
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P1', 'ChipA', '1.0', 'Nokia Corporation', 'Type1', 'Level1', '2020-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P2', 'ChipA', '1.0', 'Nokia Corporation', 'Type1', 'Level1', '2020-01-02');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P3', 'ChipA', '1.0', 'Nokia Corporation', 'Type1', 'Level1', '2020-01-03');
-- ChipB for Nokia: count = 1
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P4', 'ChipB', '1.0', 'Nokia Corporation', 'Type1', 'Level1', '2021-01-01');
-- ChipC for Nokia: count = 1 (duplicate count of 1 to kill SELECT DISTINCT mutants)
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P5', 'ChipC', '1.0', 'Nokia Corporation', 'Type1', 'Level1', '2022-01-01');
-- Non-matching companies sharing the same chip_model (kills missing WHERE or missing company_name in GROUP BY)
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P6', 'ChipB', '1.0', 'Samsung', 'Type1', 'Level1', '2021-01-02');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P7', 'ChipA', '1.0', 'Nokia', 'Type1', 'Level1', '2020-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "chip_model", "company_name", COUNT(*) AS "n" FROM "phone" GROUP BY "chip_model", "company_name") WHERE ("company_name" = 'Nokia Corporation') ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM phone WHERE Company_name = 'Nokia Corporation';

/*
Prediction Result:
(5,)
*/