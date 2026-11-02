-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_D', 2001.0, 2002.0, 2005.0, '1', 'No', 'No');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_B', 2002.0, 2003.0, 2003.0, '2', 'Yes', 'No');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_E', 2003.0, 2005.0, 2001.0, '1', 'Yes', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_A', 2004.0, 2004.0, 2004.0, '4', 'No', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_C', 2005.0, 2001.0, 2002.0, '2', 'Yes', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_F', NULL, 2000.0, 2000.0, '1', 'No', 'No');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'A', 'Text');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_1', 'Chip_B', '1.0', 'CompA', 'Type1', 'Level1', '2002-05-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_2', 'Chip_B', '1.0', 'CompB', 'Type2', 'Level2', '2003-06-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_3', 'Chip_C', '1.0', 'CompC', 'Type1', 'Level1', '2005-07-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name FROM chip_model WHERE (launch_year <= 2002.0 OR launch_year <= 2004.0) ORDER BY model_name;

/*
Gold Result:
('Chip_A',)
('Chip_B',)
('Chip_D',)
('Chip_E',)
*/

-- Prediction Query
SELECT Model_name FROM chip_model WHERE Launch_year BETWEEN 2002 AND 2004;

/*
Prediction Result:
('Chip_B',)
('Chip_E',)
('Chip_A',)
*/