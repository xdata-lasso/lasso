-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB) VALUES ('ModelA', 2000.0, 100.0);
INSERT INTO chip_model (Model_name, Launch_year, RAM_MiB) VALUES ('ModelB', 2001.0, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, minram_mib AS ram_mib FROM (SELECT * FROM (SELECT * FROM (SELECT launch_year, model_name, MIN(ram_mib) AS minram_mib FROM chip_model GROUP BY launch_year, model_name) ORDER BY launch_year) LIMIT 1);

/*
Gold Result:
('ModelA', 100.0)
*/

-- Prediction Query
SELECT Model_name, RAM_MiB FROM chip_model ORDER BY RAM_MiB ASC, chip_model.model_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('ModelB', 50.0)
*/