-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chip_model (model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth) VALUES ('default1', 2.0, NULL, NULL, NULL, NULL, 'default1'), ('default2', 0.0, NULL, 2.0, 'default2', 'default1', 'default1'), ('unique_2', 1.0, 2.0, 2.0, 'default2', 'default2', 'default2'), ('unique_3', 0.0, NULL, 2.0, 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, minram_mib AS ram_mib FROM (SELECT * FROM (SELECT * FROM (SELECT launch_year, model_name, MIN(ram_mib) AS minram_mib FROM chip_model GROUP BY launch_year, model_name) ORDER BY launch_year) LIMIT 1);

/*
Gold Result:
('default2', None)
*/

-- Prediction Query
SELECT Model_name, RAM_MiB FROM chip_model ORDER BY RAM_MiB ASC, chip_model.model_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', None)
*/