-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chip_model" ("Model_name") VALUES ('C1');
INSERT INTO "screen_mode" ("Graphics_mode", "Type") VALUES (1.0, 'Text');
INSERT INTO "phone" ("Hardware_Model_name", "chip_model", "screen_mode", "Company_name") VALUES ('N95', 'C1', '1.0', 'Nokia Corporation');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "hardware_model_name" FROM (SELECT "LHS"."graphics_mode" AS "graphics_mode", "LHS"."char_cells" AS "char_cells", "LHS"."pixels" AS "pixels", "LHS"."hardware_colours" AS "hardware_colours", "LHS"."used_kb" AS "used_kb", "LHS"."map" AS "map", "LHS"."type" AS "type", "RHS"."company_name" AS "company_name", "RHS"."hardware_model_name" AS "hardware_model_name", "RHS"."accreditation_type" AS "accreditation_type", "RHS"."accreditation_level" AS "accreditation_level", "RHS"."date" AS "date", "RHS"."chip_model" AS "chip_model", "RHS"."screen_mode" AS "screen_mode" FROM "screen_mode" AS "LHS" CROSS JOIN "phone" AS "RHS") WHERE ("company_name" = 'Nokia Corporation' AND "type" = 'Text') ORDER BY hardware_model_name, "hardware_model_name" NULLS LAST;

/*
Gold Result:
('N95',)
*/

-- Prediction Query
SELECT DISTINCT T2.Hardware_Model_name FROM screen_mode AS T1 JOIN phone AS T2 ON T1.Graphics_mode = T2.screen_mode WHERE t2.Company_name = 'Nokia Corporation' AND T1.Type <> 'Text';

/*
Prediction Result:
*/