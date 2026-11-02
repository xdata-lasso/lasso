-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Zeta_9', 2020.0, 64.0, 128.0, '1', 'Yes', '4.0');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Alpha_1', 2022.0, 256.0, 64.0, '2', 'No', '5.0');
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Mu_5', 2018.0, 128.0, 256.0, '0', 'Yes', '3.0');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (1.0, '80x25', '640x480', 16.0, 32.0, 'Linear', 'Text');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_X', 'Alpha_1', '1.0', 'Acme', 'Full', 'A', '2022-01-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_Y', 'Alpha_1', '1.0', 'Acme', 'Provisional', 'B', '2022-06-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('Phone_Z', 'Mu_5', '1.0', 'BetaCorp', 'Full', 'A', '2019-03-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name FROM chip_model ORDER BY model_name;

/*
Gold Result:
('Alpha_1',)
('Mu_5',)
('Zeta_9',)
*/

-- Prediction Query
SELECT model_name FROM chip_model ORDER BY launch_year, chip_model.model_name NULLS LAST;

/*
Prediction Result:
('Mu_5',)
('Zeta_9',)
('Alpha_1',)
*/