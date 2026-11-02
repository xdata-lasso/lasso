-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB, ROM_MiB, Slots, WiFi, Bluetooth) VALUES ('Chip_A', 2019.0, 2048.0, 32.0, 'Single', 'Yes', '4.2');
INSERT INTO screen_mode (Graphics_mode, Char_cells, Pixels, Hardware_colours, used_kb, map, Type) VALUES (2.0, '40x25', '1280x720', 8.0, 16.0, 'Planar', 'LCD');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sp1', 'Chip_A', '2.0', 'Maker1', 'Type_1', 'Split_Level', '2020-01-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sp2', 'Chip_A', '2.0', 'Maker1', 'Type_1', 'Split_Level', '2020-01-02');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sp3', 'Chip_A', '2.0', 'Maker1', 'Type_2', 'Split_Level', '2020-01-03');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sp4', 'Chip_A', '2.0', 'Maker1', 'Type_2', 'Split_Level', '2020-01-04');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sh1', 'Chip_A', '2.0', 'Maker2', 'Shared_Type', 'Level_1', '2020-02-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sh2', 'Chip_A', '2.0', 'Maker2', 'Shared_Type', 'Level_1', '2020-02-02');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sh3', 'Chip_A', '2.0', 'Maker2', 'Shared_Type', 'Level_2', '2020-02-03');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sh4', 'Chip_A', '2.0', 'Maker2', 'Shared_Type', 'Level_2', '2020-02-04');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpA1', 'Chip_A', '2.0', 'Maker3', 'Type_A', 'Dup_Level', '2020-03-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpA2', 'Chip_A', '2.0', 'Maker3', 'Type_A', 'Dup_Level', '2020-03-02');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpA3', 'Chip_A', '2.0', 'Maker3', 'Type_A', 'Dup_Level', '2020-03-03');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpA4', 'Chip_A', '2.0', 'Maker3', 'Type_A', 'Dup_Level', '2020-03-04');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpB1', 'Chip_A', '2.0', 'Maker3', 'Type_B', 'Dup_Level', '2020-04-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpB2', 'Chip_A', '2.0', 'Maker3', 'Type_B', 'Dup_Level', '2020-04-02');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpB3', 'Chip_A', '2.0', 'Maker3', 'Type_B', 'Dup_Level', '2020-04-03');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_DpB4', 'Chip_A', '2.0', 'Maker3', 'Type_B', 'Dup_Level', '2020-04-04');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sg1', 'Chip_A', '2.0', 'Maker4', 'Type_C', 'Single_Level', '2020-05-01');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sg2', 'Chip_A', '2.0', 'Maker4', 'Type_C', 'Single_Level', '2020-05-02');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sg3', 'Chip_A', '2.0', 'Maker4', 'Type_C', 'Single_Level', '2020-05-03');
INSERT INTO phone (Hardware_Model_name, chip_model, screen_mode, Company_name, Accreditation_type, Accreditation_level, Date) VALUES ('H_Sg4', 'Chip_A', '2.0', 'Maker4', 'Type_C', 'Single_Level', '2020-05-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT accreditation_level FROM (SELECT accreditation_level, accreditation_type, COUNT(*) AS n FROM phone GROUP BY accreditation_level, accreditation_type) WHERE (n > 3) ORDER BY accreditation_level;

/*
Gold Result:
('Dup_Level',)
('Dup_Level',)
('Single_Level',)
*/

-- Prediction Query
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING COUNT(*) > 3;

/*
Prediction Result:
('Dup_Level',)
('Single_Level',)
('Split_Level',)
*/