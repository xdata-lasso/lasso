-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (inserted out of alphabetical order), column order/swapping, and JOIN mutations (0, 1, and >1 references in the 'phone' table).
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('Snapdragon 800', 2013.0, 2048.0, 4096.0, '1', 'Yes', '4.0');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('A10 Fusion', 2016.0, 3072.0, 8192.0, '0', '802.11ac', '4.2');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('Exynos 5', 2012.0, 1024.0, 2048.0, '2', 'No', '3.0');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'VGA', 'Graphics');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('Phone_X', 'Snapdragon 800', '1.0', 'AlphaCorp', 'Full', 'Level 1', '2014-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('Phone_Y', 'Snapdragon 800', '1.0', 'BetaCorp', 'Provisional', 'Level 2', '2014-05-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('Phone_Z', 'A10 Fusion', '1.0', 'GammaCorp', 'Full', 'Level 1', '2016-10-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth FROM chip_model ORDER BY model_name;

/*
Gold Result:
('A10 Fusion', 2016.0, 3072.0, 8192.0, '0', '802.11ac', '4.2')
('Exynos 5', 2012.0, 1024.0, 2048.0, '2', 'No', '3.0')
('Snapdragon 800', 2013.0, 2048.0, 4096.0, '1', 'Yes', '4.0')
*/

-- Prediction Query
SELECT * FROM chip_model;

/*
Prediction Result:
('Snapdragon 800', 2013.0, 2048.0, 4096.0, '1', 'Yes', '4.0')
('A10 Fusion', 2016.0, 3072.0, 8192.0, '0', '802.11ac', '4.2')
('Exynos 5', 2012.0, 1024.0, 2048.0, '2', 'No', '3.0')
*/