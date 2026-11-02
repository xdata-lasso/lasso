-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filtering ('USA' vs others), duplicate names (SELECT vs SELECT DISTINCT),
-- and ordering by name ascending when insert order is reversed.
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'Zeta Corp', 'UK', 'Tech', 10.5, 1.2, 50.0, '100');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'Alpha Inc', 'USA', 'Finance', 20.0, 3.5, 200.0, '150');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (3, 'Beta Ltd', 'Canada', 'Retail', 5.0, 0.5, 15.0, '25');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (4, 'Alpha Inc', 'Germany', 'Auto', 80.0, 5.0, 120.0, '90');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (5, 'Beta Ltd', 'Japan', 'Tech', 12.0, 1.8, 40.0, '60');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "companies" WHERE ("headquarters" <> 'USA') ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Beta Ltd',)
('Beta Ltd',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT name FROM Companies WHERE Headquarters <> 'USA';

/*
Prediction Result:
('Zeta Corp',)
('Beta Ltd',)
('Alpha Inc',)
('Beta Ltd',)
*/