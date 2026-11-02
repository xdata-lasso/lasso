-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests composite GROUP BY (accreditation_level, accreditation_type) vs single column GROUP BY.
-- Also tests absence of DISTINCT in the outer SELECT when the same accreditation_level has multiple accreditation_types with n > 3.
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('Chip1', 2020.0, 4096.0, 65536.0, '1', 'Yes', '5.0');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '1920x1080', 16777216.0, 2048.0, 'Linear', 'OLED');
-- Same level 'Level_Split', two types ('T1', 'T2') with 2 rows each.
-- Combined level count = 4, but per (level, type) count = 2. Should NOT be returned.
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P1', 'Chip1', '1.0', 'CompA', 'T1', 'Level_Split', '2021-01-01');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P2', 'Chip1', '1.0', 'CompA', 'T1', 'Level_Split', '2021-01-02');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P3', 'Chip1', '1.0', 'CompA', 'T2', 'Level_Split', '2021-01-03');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P4', 'Chip1', '1.0', 'CompA', 'T2', 'Level_Split', '2021-01-04');
-- Same type 'Type_Split', two levels ('L1', 'L2') with 2 rows each.
-- Combined type count = 4, but per (level, type) count = 2. Should NOT be returned.
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P5', 'Chip1', '1.0', 'CompA', 'Type_Split', 'L1', '2021-01-05');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P6', 'Chip1', '1.0', 'CompA', 'Type_Split', 'L1', '2021-01-06');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P7', 'Chip1', '1.0', 'CompA', 'Type_Split', 'L2', '2021-01-07');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P8', 'Chip1', '1.0', 'CompA', 'Type_Split', 'L2', '2021-01-08');
-- Same level 'Level_Dup', two types ('T_A', 'T_B') each having 4 rows.
-- Both groups exceed 3, so 'Level_Dup' MUST be output twice (kills mutants that add DISTINCT).
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P9', 'Chip1', '1.0', 'CompB', 'T_A', 'Level_Dup', '2021-01-09');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P10', 'Chip1', '1.0', 'CompB', 'T_A', 'Level_Dup', '2021-01-10');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P11', 'Chip1', '1.0', 'CompB', 'T_A', 'Level_Dup', '2021-01-11');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P12', 'Chip1', '1.0', 'CompB', 'T_A', 'Level_Dup', '2021-01-12');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P13', 'Chip1', '1.0', 'CompB', 'T_B', 'Level_Dup', '2021-01-13');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P14', 'Chip1', '1.0', 'CompB', 'T_B', 'Level_Dup', '2021-01-14');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P15', 'Chip1', '1.0', 'CompB', 'T_B', 'Level_Dup', '2021-01-15');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('P16', 'Chip1', '1.0', 'CompB', 'T_B', 'Level_Dup', '2021-01-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT accreditation_level FROM (SELECT accreditation_level, accreditation_type, COUNT(*) AS n FROM phone GROUP BY accreditation_level, accreditation_type) WHERE (n > 3) ORDER BY accreditation_level;

/*
Gold Result:
('Level_Dup',)
('Level_Dup',)
*/

-- Prediction Query
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING COUNT(*) > 3;

/*
Prediction Result:
('Level_Dup',)
('Level_Split',)
*/