-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Olivia Moore', 1007.5, 1008.5, 1009.5, 'knowledge', 'grow', 'fall');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Shannon Ray', 1013.5, 1014.5, 1015.5, 'sea', 'available', 'answer');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1010.5, '(635)211-6155', 'show', 1011.5, 1012.5, 'machine', 'not');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1016.5, '+1-634-313-1647x52553', 'politics', 1017.5, 1018.5, 'prove', 'Congress');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Thomas Miller', 'Olivia Moore', 1010.5, 'Nokia Corporation', 'finally', 'themselves', 'production');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Danielle Ford', NULL, 1016.5, 'Nokia Corporation', 'expect', 'wish', 'push');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "chip_model", "company_name", COUNT(*) AS "n" FROM "phone" GROUP BY "chip_model", "company_name") WHERE ("company_name" = 'Nokia Corporation') ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM phone WHERE Company_name = 'Nokia Corporation';

/*
Prediction Result:
(2,)
*/