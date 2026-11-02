-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_C', 2002.0, 64.0, 128.0, '2 slots', 'Yes', 'No');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_A', 2005.0, 128.0, 256.0, '1 slot', 'No', 'Yes');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_D', 2001.0, 32.0, 64.0, '0 slots', '802.11b', '1.1');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_B', 2008.0, 256.0, 512.0, '4 slots', '802.11g', '2.0');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (1.0, '40x25', '320x200', 16.0, 8.0, 'MapA', 'Graphics');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (2.0, '80x25', '640x480', 256.0, 16.0, 'MapB', 'Text');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_1', 'Chip_B', '1.0', 'Nokia', 'Full', 'Level_1', '2008-05-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_2', 'Chip_C', '1.0', 'Sony', 'Provisional', 'Level_2', '2002-03-15');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_3', 'Chip_C', '2.0', 'Motorola', 'Full', 'Level_1', '2003-07-20');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_4', 'Chip_D', '2.0', 'Siemens', 'Full', 'Level_3', '2001-11-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth FROM chip_model ORDER BY model_name;

/*
Gold Result:
('Chip_A', 2005.0, 128.0, 256.0, '1 slot', 'No', 'Yes')
('Chip_B', 2008.0, 256.0, 512.0, '4 slots', '802.11g', '2.0')
('Chip_C', 2002.0, 64.0, 128.0, '2 slots', 'Yes', 'No')
('Chip_D', 2001.0, 32.0, 64.0, '0 slots', '802.11b', '1.1')
*/

-- Prediction Query
SELECT * FROM chip_model;

/*
Prediction Result:
('Chip_C', 2002.0, 64.0, 128.0, '2 slots', 'Yes', 'No')
('Chip_A', 2005.0, 128.0, 256.0, '1 slot', 'No', 'Yes')
('Chip_D', 2001.0, 32.0, 64.0, '0 slots', '802.11b', '1.1')
('Chip_B', 2008.0, 256.0, 512.0, '4 slots', '802.11g', '2.0')
*/