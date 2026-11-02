-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chip_model (model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth) VALUES ('default2', 0.0, NULL, 0.0, 'default2', NULL, 'default2'), ('default1', NULL, 1.0, 1.0, NULL, NULL, 'default1'), ('unique_2', 0.0, 1.0, NULL, NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth FROM chip_model ORDER BY model_name;

/*
Gold Result:
('default1', None, 1.0, 1.0, None, None, 'default1')
('default2', 0.0, None, 0.0, 'default2', None, 'default2')
('unique_2', 0.0, 1.0, None, None, None, 'default1')
*/

-- Prediction Query
SELECT * FROM chip_model;

/*
Prediction Result:
('default2', 0.0, None, 0.0, 'default2', None, 'default2')
('default1', None, 1.0, 1.0, None, None, 'default1')
('unique_2', 0.0, 1.0, None, None, None, 'default1')
*/