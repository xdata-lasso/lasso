-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("Hardware_Model_name", "Accreditation_type", "Accreditation_level") VALUES ('M1', 'T1', 'L1');
INSERT INTO "phone" ("Hardware_Model_name", "Accreditation_type", "Accreditation_level") VALUES ('M2', 'T1', 'L1');
INSERT INTO "phone" ("Hardware_Model_name", "Accreditation_type", "Accreditation_level") VALUES ('M3', 'T2', 'L1');
INSERT INTO "phone" ("Hardware_Model_name", "Accreditation_type", "Accreditation_level") VALUES ('M4', 'T2', 'L1');
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
('L1',)
*/