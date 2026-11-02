-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO screen_mode (graphics_mode, char_cells, pixels, hardware_colours, used_kb, map, type) VALUES (1.0, 'default2', 'Nokia Corporation', 0.0, 0.0, NULL, 'Nokia Corporation'), (0.0, 'default1', 'default2', NULL, 0.0, 'Nokia Corporation', 'default2'), (12500.0, NULL, 'Text', NULL, NULL, 'Text', 'default1'), (25000.0, 'Nokia Corporation', 'Nokia Corporation', 0.0, 0.0, 'default2', 'default1'), (37500.0, 'default1', NULL, 0.0, NULL, NULL, 'default1'), (50000.0, 'Nokia Corporation', 'Text', NULL, 0.0, 'Text', 'Text'), (62500.0, 'default2', 'default1', 1.0, 0.0, 'default2', NULL), (75000.0, NULL, 'Text', 1.0, NULL, 'default1', 'Nokia Corporation'), (87500.0, 'Text', 'Text', 0.0, 1.0, 'default2', 'default1'), (100000.0, 'default2', 'Text', 1.0, 1.0, 'default1', 'Text');
INSERT INTO chip_model (model_name, launch_year, ram_mib, rom_mib, slots, wifi, bluetooth) VALUES ('Text', 0.0, 1.0, NULL, 'Nokia Corporation', 'Text', NULL);
INSERT INTO phone (hardware_model_name, chip_model, screen_mode, company_name, accreditation_type, accreditation_level, date) VALUES ('Nokia Corporation', NULL, 62500.0, 'Nokia Corporation', 'Nokia Corporation', 'Text', NULL), ('Text', 'Text', 50000.0, 'default1', NULL, 'default1', 'Text'), ('default2', NULL, 25000.0, 'default1', 'Nokia Corporation', 'default2', 'default1'), ('default1', 'Text', 100000.0, 'Nokia Corporation', 'Nokia Corporation', 'default2', 'Text'), ('unique_4', 'Text', 37500.0, 'Nokia Corporation', 'Text', 'Nokia Corporation', NULL), ('unique_5', 'Text', 62500.0, 'default2', 'Nokia Corporation', NULL, NULL), ('unique_6', NULL, 12500.0, NULL, 'default2', 'default1', 'Text'), ('unique_7', NULL, NULL, NULL, 'default2', 'Text', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "hardware_model_name" FROM (SELECT "LHS"."graphics_mode" AS "graphics_mode", "LHS"."char_cells" AS "char_cells", "LHS"."pixels" AS "pixels", "LHS"."hardware_colours" AS "hardware_colours", "LHS"."used_kb" AS "used_kb", "LHS"."map" AS "map", "LHS"."type" AS "type", "RHS"."company_name" AS "company_name", "RHS"."hardware_model_name" AS "hardware_model_name", "RHS"."accreditation_type" AS "accreditation_type", "RHS"."accreditation_level" AS "accreditation_level", "RHS"."date" AS "date", "RHS"."chip_model" AS "chip_model", "RHS"."screen_mode" AS "screen_mode" FROM "screen_mode" AS "LHS" CROSS JOIN "phone" AS "RHS") WHERE ("company_name" = 'Nokia Corporation' AND "type" = 'Text') ORDER BY hardware_model_name, "hardware_model_name" NULLS LAST;

/*
Gold Result:
('Nokia Corporation',)
('default1',)
('unique_4',)
*/

-- Prediction Query
SELECT DISTINCT T2.Hardware_Model_name FROM screen_mode AS T1 JOIN phone AS T2 ON T1.Graphics_mode = T2.screen_mode WHERE t2.Company_name = 'Nokia Corporation' AND T1.Type <> 'Text';

/*
Prediction Result:
('unique_4',)
*/