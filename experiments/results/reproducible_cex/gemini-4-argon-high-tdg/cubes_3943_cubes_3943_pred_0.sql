-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Alpha-X1', 2005.0, 32.0, 64.0, '1 SD', 'Yes', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Beta-Z9', 1998.0, 128.0, 256.0, '2 CF', 'No', 'No');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Gamma-M3', 2010.0, 16.0, 512.0, '1 microSD', 'Yes', 'Yes');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (1.0, '40x25', '320x200', 16.0, 8.0, 'CGA', 'Graphics');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone-100', 'Alpha-X1', 1.0, 'Acme Corp', 'Full', 'Level 1', '2005-06-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone-200', 'Gamma-M3', 1.0, 'BetaTech', 'Provisional', 'Level 2', '2010-09-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, minram_mib AS ram_mib FROM (SELECT * FROM (SELECT * FROM (SELECT launch_year, model_name, MIN(ram_mib) AS minram_mib FROM chip_model GROUP BY launch_year, model_name) ORDER BY launch_year) LIMIT 1);

/*
Gold Result:
('Beta-Z9', 128.0)
*/

-- Prediction Query
SELECT Model_name, RAM_MiB FROM chip_model ORDER BY RAM_MiB ASC, chip_model.model_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Gamma-M3', 16.0)
*/