-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (inserted out of alphabetical order), column distinctness, and potential unintended joins with phone/screen_mode (including 0, 1, and multiple references).
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('Snapdragon 888', 2020.0, 4096.0, 8192.0, '2 SIM', 'Wi-Fi 6', '5.2');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('Apple A14', 2021.0, 2048.0, 4096.0, '1 eSIM', 'Wi-Fi 6E', '5.0');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('Exynos 2100', 2019.0, 8192.0, 16384.0, 'Dual SIM', 'Wi-Fi 5', '4.2');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '1920x1080', 16777216.0, 2048.0, 'Linear', 'OLED');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('Galaxy S21', 'Snapdragon 888', '1.0', 'Samsung', 'FCC', 'Level 1', '2021-01-29');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('Mi 11', 'Snapdragon 888', '1.0', 'Xiaomi', 'CE', 'Level 2', '2021-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('iPhone 12', 'Apple A14', '1.0', 'Apple', 'FCC', 'Level 1', '2020-10-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth FROM chip_model ORDER BY model_name;

/*
Gold Result:
('Apple A14', 2021.0, 2048.0, 4096.0, '1 eSIM', 'Wi-Fi 6E', '5.0')
('Exynos 2100', 2019.0, 8192.0, 16384.0, 'Dual SIM', 'Wi-Fi 5', '4.2')
('Snapdragon 888', 2020.0, 4096.0, 8192.0, '2 SIM', 'Wi-Fi 6', '5.2')
*/

-- Prediction Query
SELECT * FROM chip_model;

/*
Prediction Result:
('Snapdragon 888', 2020.0, 4096.0, 8192.0, '2 SIM', 'Wi-Fi 6', '5.2')
('Apple A14', 2021.0, 2048.0, 4096.0, '1 eSIM', 'Wi-Fi 6E', '5.0')
('Exynos 2100', 2019.0, 8192.0, 16384.0, 'Dual SIM', 'Wi-Fi 5', '4.2')
*/