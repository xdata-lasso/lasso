-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_Z', 2000.0, 32.0, 64.0, '1', 'No', 'No');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_M', 2002.0, 64.0, 128.0, '2', 'Yes', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_A', 2003.0, 128.0, 256.0, '1', 'Yes', 'No');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_K', 2004.0, 16.0, 32.0, '1', 'No', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_B', 2005.0, 256.0, 512.0, '2', 'Yes', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_N', NULL, 64.0, 64.0, '1', 'Yes', 'Yes');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'VGA', 'Graphics');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_1', 'Chip_M', '1.0', 'Acme', 'Full', 'A', '2002');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_2', 'Chip_M', '1.0', 'BetaCorp', 'Full', 'A', '2003');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_3', 'Chip_A', '1.0', 'Acme', 'Provisional', 'B', '2003');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_4', 'Chip_B', '1.0', 'Acme', 'Full', 'A', '2005');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_5', 'Chip_N', '1.0', 'Gamma', 'Full', 'A', '2001');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name FROM chip_model WHERE (launch_year <= 2002.0 OR launch_year <= 2004.0) ORDER BY model_name;

/*
Gold Result:
('Chip_A',)
('Chip_K',)
('Chip_M',)
('Chip_Z',)
*/

-- Prediction Query
SELECT Model_name FROM chip_model WHERE Launch_year BETWEEN 2002 AND 2004;

/*
Prediction Result:
('Chip_M',)
('Chip_A',)
('Chip_K',)
*/