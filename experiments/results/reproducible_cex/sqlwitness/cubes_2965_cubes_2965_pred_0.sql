-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO companies (id, name, headquarters, industry, sales_billion, profits_billion, assets_billion, market_value_billion) VALUES (0, 'default2', 'default1', 'default1', 1.0, 0.0, 1.0, NULL), (1, 'default1', 'USA', 'default2', NULL, 0.0, NULL, NULL), (2, 'default2', 'USA', NULL, 0.0, 0.0, 1.0, 'default2'), (3, 'USA', 'default1', 'USA', 1.0, 1.0, NULL, 'default1'), (4, NULL, 'default1', 'USA', 0.0, NULL, NULL, 'USA'), (5, 'USA', 'default2', NULL, 1.0, 1.0, NULL, 'USA'), (6, 'default2', 'default2', 'default2', 1.0, 1.0, NULL, 'default2'), (7, 'USA', 'default1', NULL, NULL, NULL, NULL, NULL), (8, 'default2', 'default1', 'default1', 1.0, 0.0, 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "companies" WHERE ("headquarters" <> 'USA') ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
(None,)
('USA',)
('USA',)
('USA',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT name FROM Companies WHERE Headquarters <> 'USA';

/*
Prediction Result:
('default2',)
('USA',)
(None,)
('USA',)
('default2',)
('USA',)
('default2',)
*/