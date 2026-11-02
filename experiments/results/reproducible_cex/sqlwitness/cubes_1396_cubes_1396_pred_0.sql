-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO screen_mode (graphics_mode, char_cells, pixels, hardware_colours, used_kb, map, type) VALUES (4.0, 'default2', NULL, 4.0, NULL, 'default2', 'default1');
INSERT INTO chip_model (model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth) VALUES ('default2', 3.0, 4.0, 2.0, NULL, 'default2', 'default1'), ('default1', 3.0, NULL, NULL, 'default1', NULL, 'default2'), ('unique_2', 4.0, 3.0, 3.0, 'default1', NULL, 'default2');
INSERT INTO phone (hardware_model_name, chip_model, screen_mode, company_name, accreditation_type, accreditation_level, date) VALUES ('default2', 'default1', 4.0, 'default1', 'default2', 'default2', 'default2'), ('default1', NULL, NULL, 'default1', 'default2', 'default2', NULL), ('unique_2', 'default2', NULL, NULL, NULL, NULL, 'default1'), ('unique_3', 'unique_2', NULL, 'default2', 'default1', 'default2', 'default2'), ('unique_4', 'default1', NULL, 'default2', 'default1', 'default2', 'default2'), ('unique_5', 'unique_2', NULL, 'default2', 'default1', NULL, 'default2'), ('unique_6', 'default2', 4.0, 'default1', 'default2', NULL, 'default2'), ('unique_7', 'unique_2', 4.0, 'default2', 'default2', 'default1', 'default1'), ('unique_8', 'default1', 4.0, 'default2', 'default2', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT accreditation_level FROM (SELECT accreditation_level, accreditation_type, COUNT(*) AS n FROM phone GROUP BY accreditation_level, accreditation_type) WHERE (n > 3) ORDER BY accreditation_level;

/*
Gold Result:
*/

-- Prediction Query
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING COUNT(*) > 3;

/*
Prediction Result:
('default2',)
*/