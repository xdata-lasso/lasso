-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_Z', 2001.0, 64.0, 128.0, '1', 'No', '1.1');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_M', 2002.0, 32.0, 64.0, '2', 'Yes', '1.2');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_B', 2003.0, 128.0, 32.0, '1', 'No', '2.0');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_A', 2004.0, 16.0, 256.0, '0', 'Yes', '2.0');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_X', 2005.0, 256.0, 512.0, '1', 'Yes', '2.1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name FROM chip_model WHERE (launch_year <= 2002.0 OR launch_year <= 2004.0) ORDER BY model_name;

/*
Gold Result:
('Chip_A',)
('Chip_B',)
('Chip_M',)
('Chip_Z',)
*/

-- Prediction Query
SELECT Model_name FROM chip_model WHERE Launch_year BETWEEN 2002 AND 2004;

/*
Prediction Result:
('Chip_M',)
('Chip_B',)
('Chip_A',)
*/