-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO buildings (id, name, city, height, stories, status) VALUES (1, 'default2', 'on-hold', 0, 1, 'default2'), (0, 'default2', NULL, 1, 1, 'on-hold'), (2, 'default1', 'default1', 1, NULL, 'default2'), (3, NULL, NULL, NULL, 1, 'on-hold'), (4, 'on-hold', NULL, NULL, 0, 'default2'), (5, NULL, 'default1', 1, 1, 'default1'), (6, 'default1', 'on-hold', 1, 0, NULL), (7, NULL, 'default2', NULL, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "buildings" WHERE ("status" = 'on-hold') ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT name FROM buildings WHERE Status = 'on-hold' ORDER BY Stories ASC, buildings.id NULLS LAST;

/*
Prediction Result:
('default2',)
(None,)
*/