-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: chip_model --
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('chi_0e5e1b', 582.588439, 680.190136, 487.053947, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('chi_4b243e', 1.0, 779.409124, 640.719621, 'ri', 'a2ypuzhsrwbb', 'p6luhvdlttil');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('chi_41d398', 22.535764, 600.048938, 240.969194, 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('model_name_3', 1.0, 741.842896, 587.783596, '000t5c4ec', 'gce', '76nium52');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('@', 582.588439, 680.190136, 487.053947, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('A', 779.409124, 640.719621, 770.236508, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('model_name_7', 1.0, 986.066566, 666.330692, 'p', 'siie', 'unw6klfa');

INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('model_name_8', 1.0, 587.783596, 558.971814, '00t5c4e', 'cigce376nium', '52zbuo4nrq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model_name, minram_mib AS ram_mib FROM (SELECT * FROM (SELECT * FROM (SELECT launch_year, model_name, MIN(ram_mib) AS minram_mib FROM chip_model GROUP BY launch_year, model_name) ORDER BY launch_year) LIMIT 1);

/*
Gold Result:
('chi_4b243e', 779.409124)
*/

-- Prediction Query
SELECT Model_name, RAM_MiB FROM chip_model ORDER BY RAM_MiB ASC, chip_model.model_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('model_name_8', 587.783596)
*/