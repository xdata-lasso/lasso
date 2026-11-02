-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_A1', 2005.0, 32.0, 64.0, '1 SD', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_A2', 2006.0, 32.0, 128.0, '1 SD', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_A3', 2007.0, 32.0, 256.0, '1 SD', '802.11b', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_A4', 2008.0, 32.0, 512.0, '1 SD', 'No', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_B1', 2009.0, 64.0, 1024.0, '1 SD', '802.11b/g', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_C1', 2010.0, 128.0, 2048.0, '1 SD', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_C2', 2011.0, 128.0, 4096.0, '1 SD', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_D1', 2012.0, 256.0, 8192.0, '1 SD', 'No', 'Yes');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '40x25', '320x200', 16.0, 8.0, 'Linear', 'Graphics');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('PH_1', 'CM_B1', '1.0', 'Nokia', 'Full', 'Level 1', '2009-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('PH_2', 'CM_B1', '1.0', 'Nokia', 'Full', 'Level 2', '2009-06-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('PH_3', 'CM_D1', '1.0', 'Sony', 'Provisional', 'Level 1', '2012-03-01');
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