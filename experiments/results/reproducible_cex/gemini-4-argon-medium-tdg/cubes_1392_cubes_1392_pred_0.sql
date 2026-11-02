-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M1', 2020.0, 256.0, 512.0, '1', '802.11b', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M2', 2020.0, 256.0, 512.0, '1', '802.11g', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M3', 2020.0, 256.0, 512.0, '1', 'No', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M4', 2021.0, 64.0, 128.0, '1', 'Yes', 'No');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M5', 2021.0, 64.0, 256.0, '2', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M6', 2022.0, 64.0, 512.0, '1', '802.11n', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M7', 2022.0, 128.0, 256.0, '1', 'Yes', 'No');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('M8', 2022.0, 512.0, 1024.0, '1', 'No', 'No');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'A', 'Text');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P1', 'M1', '1.0', 'CompA', 'Type1', 'Level1', '2020-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P2', 'M1', '1.0', 'CompB', 'Type1', 'Level1', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "ram_mib", COUNT(*) AS "n" FROM (SELECT * FROM "chip_model" WHERE ("wifi" <> 'No')) GROUP BY ram_mib) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM chip_model WHERE wifi = 'No';

/*
Prediction Result:
(2,)
*/