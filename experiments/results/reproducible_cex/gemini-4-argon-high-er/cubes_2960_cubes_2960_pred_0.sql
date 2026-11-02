-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'A', 'City1', 100, 20, 'on-hold');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'B', 'City2', 100, 10, 'on-hold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "buildings" WHERE ("status" = 'on-hold') ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM buildings WHERE Status = 'on-hold' ORDER BY Stories ASC, buildings.id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/