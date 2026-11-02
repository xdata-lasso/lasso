-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (101, 'Apex Tower', 'New York', 350, 80, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (102, 'Horizon Center', 'Chicago', 280, 65, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (103, 'Pacific Plaza', 'San Francisco', 220, 50, 'Under Construction');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'TeleCom One', 'New York', 'Telecommunications', 120.5, 50.0, 300.0, '250.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'First Bank', 'Chicago', 'Banking', 85.0, 10.0, 950.0, '180.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (3, 'AutoWorks', 'Detroit', 'Automotive', 150.0, 30.0, 210.0, '95.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (4, 'LogiCorp', 'Atlanta', 'Logistics', 40.0, 99.0, 60.0, '70.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (5, 'SolarGrid', 'Houston', 'Energy', 90.0, 10.0, 180.0, '110.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (6, 'MediCare Plus', 'Boston', 'Healthcare', 110.0, 30.0, 140.0, '200.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (7, 'ShopMart', 'Seattle', 'Retail', 200.0, 30.0, 130.0, '160.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (8, 'AeroSpace Inc', 'Seattle', 'Aerospace', 75.0, 5.0, 120.0, '88.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (9, 'ChemLab', 'Wilmington', 'Chemicals', 45.0, 5.0, 55.0, '40.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (10, 'BuildRight', 'Dallas', 'Construction', 30.0, 5.0, 35.0, '25.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (11, 'AgriGrow', 'Omaha', 'Agriculture', 28.0, 5.0, 42.0, '30.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (12, 'CloudNet', 'San Jose', 'Software', 65.0, 99.0, 80.0, '310.0');
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (101, 1, 2015);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (102, 1, 2018);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (102, 2, 2012);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (103, 5, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT industry FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value_billion AS market_value_billion FROM companies AS LHS INNER JOIN (SELECT profits_billion, COUNT(*) AS n FROM companies GROUP BY profits_billion) AS RHS ON (LHS.id = RHS.n AND LHS.profits_billion = RHS.profits_billion)) ORDER BY industry;

/*
Gold Result:
('Automotive',)
('Banking',)
('Telecommunications',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aerospace',)
*/