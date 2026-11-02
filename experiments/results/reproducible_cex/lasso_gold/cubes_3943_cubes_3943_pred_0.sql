-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Benjamin Stanley', 1019.5, 1020.5, 1024.5, 'religious', 'result', 'prove');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Victoria Wyatt', 1019.5, 1027.5, 1033.5, 'example', 'raise', 'Congress');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Jamie Chavez', 1019.5, 1034.5, 1042.5, 'science', 'away', 'none');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Carla Kelly', 1019.5, 1041.5, 1051.5, 'write', 'politics', 'shoulder');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Joel Nelson', 1028.5, NULL, 1033.5, 'attorney', 'our', 'difference');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Melissa Robinson', 1028.5, NULL, 1042.5, 'development', 'under', 'reality');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Randy Brown', 1028.5, NULL, 1051.5, 'white', 'serious', 'money');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Renee Morales', 1028.5, NULL, 1060.5, 'yes', 'forward', 'individual');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, minram_mib AS ram_mib FROM (SELECT * FROM (SELECT * FROM (SELECT launch_year, model_name, MIN(ram_mib) AS minram_mib FROM chip_model GROUP BY launch_year, model_name) ORDER BY launch_year) LIMIT 1);

/*
Gold Result:
('Benjamin Stanley', 1020.5)
*/

-- Prediction Query
SELECT Model_name, RAM_MiB FROM chip_model ORDER BY RAM_MiB ASC, chip_model.model_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Joel Nelson', None)
*/