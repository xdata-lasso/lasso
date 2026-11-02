-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (1, 'Tower A', 'New York', 300, 60, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (2, 'Plaza B', 'Chicago', 200, 40, 'Under Construction');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'Zeta Corp', 'Boston', 'Technology', 50.5, 10.2, 100.0, '200.5');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'Alpha Inc', 'Seattle', 'Banking', 120.0, -5.0, 500.0, '80.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (3, 'Beta LLC', 'Austin', 'Technology', 10.0, 0.0, 25.0, '30.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (4, 'Gamma Co', 'Denver', 'Healthcare', 80.0, 15.0, 150.0, '300.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (5, 'Delta Ltd', 'Miami', 'Apparel', 5.0, 1.0, 10.0, '12.0');
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (1, 1, 2015);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (2, 3, 2018);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (1, 4, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT industry FROM companies ORDER BY industry;

/*
Gold Result:
('Apparel',)
('Banking',)
('Healthcare',)
('Technology',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST;

/*
Prediction Result:
('Technology',)
('Apparel',)
('Banking',)
('Healthcare',)
*/