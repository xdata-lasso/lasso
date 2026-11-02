-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*), ORDER BY (inserted out of order), duplicate output counts (SELECT vs SELECT DISTINCT), and filtering out other companies/NULLs.
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM1', 2020.0, 1024.0, 2048.0, '1', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM2', 2021.0, 2048.0, 4096.0, '2', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM3', 2022.0, 4096.0, 8192.0, '1', 'No', 'Yes');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'MapA', 'Text');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P1', 'CM1', '1.0', 'Nokia Corporation', 'TypeA', 'Level1', '2020-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P2', 'CM1', '1.0', 'Nokia Corporation', 'TypeA', 'Level1', '2020-01-02');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P3', 'CM1', '1.0', 'Nokia Corporation', 'TypeA', 'Level1', '2020-01-03');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P4', 'CM2', '1.0', 'Nokia Corporation', 'TypeB', 'Level2', '2021-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P5', 'CM3', '1.0', 'Nokia Corporation', 'TypeC', 'Level3', '2022-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P6', 'CM1', '1.0', 'Samsung', 'TypeA', 'Level1', '2020-02-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P7', 'CM2', '1.0', NULL, 'TypeA', 'Level1', '2020-03-01');
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