-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (1014, 'Gabrielle Davis', 'West Melanieview', NULL, 1016, 'surface');
INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (1017, 'Joe Martinez', 'Millerport', 1018, 1019, 'themselves');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM buildings ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
('Gabrielle Davis',)
('Joe Martinez',)
*/

-- Prediction Query
SELECT name FROM buildings ORDER BY Height DESC, buildings.id NULLS LAST;

/*
Prediction Result:
('Joe Martinez',)
('Gabrielle Davis',)
*/