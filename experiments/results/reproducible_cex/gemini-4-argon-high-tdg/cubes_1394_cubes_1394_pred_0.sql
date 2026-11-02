-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('OMAP 2420', 2006.0, 64.0, 128.0, 'microSD', '802.11b/g', '2.0');
INSERT INTO "chip_model" ("Model_name", "Launch_year", "RAM_MiB", "ROM_MiB", "Slots", "WiFi", "Bluetooth") VALUES ('OMAP 1710', 2005.0, 32.0, 64.0, 'MMC', 'None', '1.2');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (1.0, '80x25', '640x200', 16.0, 4.0, 'B8000', 'Text');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (2.0, '40x25', '320x200', 16.0, 2.0, 'B8000', 'Text');
INSERT INTO "screen_mode" ("Graphics_mode", "Char_cells", "Pixels", "Hardware_colours", "used_kb", "map", "Type") VALUES (3.0, 'None', '320x240', 256.0, 64.0, 'A0000', 'Graphics');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('N95', 'OMAP 2420', '1.0', 'Nokia Corporation', 'GCF', 'Full', '2007-03');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('N70', 'OMAP 1710', '3.0', 'Nokia Corporation', 'GCF', 'Full', '2005-09');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('E61', NULL, NULL, 'Nokia Corporation', 'PTCRB', 'Partial', '2006-05');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name", "Accreditation_type", "Accreditation_level", "Date") VALUES ('K800i', 'OMAP 1710', '1.0', 'Sony Ericsson', 'GCF', 'Full', '2006-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "hardware_model_name" FROM (SELECT "LHS"."graphics_mode" AS "graphics_mode", "LHS"."char_cells" AS "char_cells", "LHS"."pixels" AS "pixels", "LHS"."hardware_colours" AS "hardware_colours", "LHS"."used_kb" AS "used_kb", "LHS"."map" AS "map", "LHS"."type" AS "type", "RHS"."company_name" AS "company_name", "RHS"."hardware_model_name" AS "hardware_model_name", "RHS"."accreditation_type" AS "accreditation_type", "RHS"."accreditation_level" AS "accreditation_level", "RHS"."date" AS "date", "RHS"."chip_model" AS "chip_model", "RHS"."screen_mode" AS "screen_mode" FROM "screen_mode" AS "LHS" CROSS JOIN "phone" AS "RHS") WHERE ("company_name" = 'Nokia Corporation' AND "type" = 'Text') ORDER BY hardware_model_name, "hardware_model_name" NULLS LAST;

/*
Gold Result:
('E61',)
('N70',)
('N95',)
*/

-- Prediction Query
SELECT DISTINCT T2.Hardware_Model_name FROM screen_mode AS T1 JOIN phone AS T2 ON T1.Graphics_mode = T2.screen_mode WHERE t2.Company_name = 'Nokia Corporation' AND T1.Type <> 'Text';

/*
Prediction Result:
('N70',)
*/