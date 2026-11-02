-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Meredith Barnes', 1007.5, 1008.5, 1009.5, 'agreement', 'option', 'decide');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Daniel Wagner', 1008.5, 1009.5, 1010.5, 'list', 'perform', 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth FROM chip_model ORDER BY model_name;

/*
Gold Result:
('Daniel Wagner', 1008.5, 1009.5, 1010.5, 'list', 'perform', 'fall')
('Meredith Barnes', 1007.5, 1008.5, 1009.5, 'agreement', 'option', 'decide')
*/

-- Prediction Query
SELECT * FROM chip_model;

/*
Prediction Result:
('Meredith Barnes', 1007.5, 1008.5, 1009.5, 'agreement', 'option', 'decide')
('Daniel Wagner', 1008.5, 1009.5, 1010.5, 'list', 'perform', 'fall')
*/