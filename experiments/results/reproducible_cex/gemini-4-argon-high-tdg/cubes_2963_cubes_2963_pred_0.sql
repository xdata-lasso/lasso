-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (10, 'Zenith Tower', 'Chicago', 100, 20, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (20, 'Apex Center', 'Boston', 300, 60, 'Under construction');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (5, 'Midtown Plaza', 'Austin', 200, 40, 'Planned');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (15, 'Apex Center', 'Denver', 150, 30, 'Completed');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'Global Corp', 'New York', 'Finance', 50.5, 5.2, 120.0, '200');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'TechNova', 'San Francisco', 'Technology', 80.0, 12.1, 95.5, '500');
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (10, 1, 2015);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (10, 2, 2018);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (20, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM buildings ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
('Apex Center',)
('Apex Center',)
('Midtown Plaza',)
('Zenith Tower',)
*/

-- Prediction Query
SELECT name FROM buildings ORDER BY Height DESC, buildings.id NULLS LAST;

/*
Prediction Result:
('Apex Center',)
('Midtown Plaza',)
('Apex Center',)
('Zenith Tower',)
*/