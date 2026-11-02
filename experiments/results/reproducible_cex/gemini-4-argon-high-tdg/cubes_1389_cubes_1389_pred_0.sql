-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_A', 2004.0, 32.0, 64.0, '1', 'Yes', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_B', 2005.0, 64.0, 128.0, '2', 'Yes', 'No');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_C', 2006.0, 128.0, 256.0, '1', 'No', 'Yes');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('CM_D', 2007.0, 256.0, 512.0, '1', 'Yes', 'Yes');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'A', 'Text');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (2.0, '40x25', '320x200', 256.0, 64.0, 'B', 'Graphics');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P1', 'CM_A', '1.0', 'Nokia Corporation', 'Full', 'Level 1', '2004-01-10');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P2', 'CM_A', '1.0', 'Nokia Corporation', 'Full', 'Level 2', '2004-02-15');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P3', 'CM_A', '2.0', 'Nokia Corporation', 'Provisional', 'Level 1', '2004-03-20');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P4', 'CM_B', '1.0', 'Nokia Corporation', 'Full', 'Level 1', '2005-05-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P5', 'CM_C', '2.0', 'Nokia Corporation', 'Full', 'Level 1', '2006-06-11');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P6', 'CM_C', '2.0', 'Nokia Corporation', 'Provisional', 'Level 2', '2006-07-12');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P7', 'CM_A', '1.0', 'Samsung', 'Full', 'Level 1', '2004-08-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P8', 'CM_A', '2.0', 'Samsung', 'Full', 'Level 1', '2004-09-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P9', 'CM_B', '1.0', 'Motorola', 'Full', 'Level 1', '2005-10-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P10', 'CM_B', '1.0', 'Motorola', 'Full', 'Level 2', '2005-11-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P11', 'CM_D', '2.0', 'Nokia', 'Full', 'Level 1', '2007-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P12', 'CM_D', '2.0', 'Nokia', 'Full', 'Level 2', '2007-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "chip_model", "company_name", COUNT(*) AS "n" FROM "phone" GROUP BY "chip_model", "company_name") WHERE ("company_name" = 'Nokia Corporation') ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM phone WHERE Company_name = 'Nokia Corporation';

/*
Prediction Result:
(6,)
*/