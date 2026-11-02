-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (1, 'Tower B', 'New York', 300, 60, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (2, 'Tower A', 'Chicago', 400, 80, 'Under Construction');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (3, 'Tower A', 'Boston', 200, 40, 'Proposed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (4, 'Tower C', 'Austin', 150, 30, 'Completed');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'Corp X', 'New York', 'Tech', 10.5, 2.1, 50.0, '100');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'Corp Y', 'Chicago', 'Finance', 20.0, 4.0, 120.0, '200');
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (1, 1, 2010);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (1, 2, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM buildings ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
('Tower A',)
('Tower A',)
('Tower B',)
('Tower C',)
*/

-- Prediction Query
SELECT name FROM buildings ORDER BY Height DESC, buildings.id NULLS LAST;

/*
Prediction Result:
('Tower A',)
('Tower B',)
('Tower A',)
('Tower C',)
*/