-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Nokia Corporation12', 4364105749583278266, 4364105749583278266, 4364105749583278266, 'Nokia Corporation', 'Nokia Corporation', 'Nokia Corporation');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Nokia Corporation14', 4364105749583278266, 4364105749583278266, 4364105749583278266, 'Nokia Corporation', 'Nokia Corporation', 'Nokia Corporation');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (8, 'Nokia Corporation', 'Nokia Corporation', 4364105749583278266, 4364105749583278266, 'Nokia Corporation', 'Nokia Corporation');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (11, 'Nokia Corporation', 'Nokia Corporation', 4364105749583278266, 4364105749583278266, 'Nokia Corporation', 'Nokia Corporation');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Nokia Corporation10', 'Nokia Corporation12', 11, 'Nokia Corporation', 'Nokia Corporation16', 'Nokia Corporation17', 'Nokia Corporation18');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Nokia Corporation9', 'Nokia Corporation14', 11, 'Nokia Corporation', 'Nokia Corporation19', 'Nokia Corporation20', 'Nokia Corporation21');
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