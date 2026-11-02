-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (10, 'Tower B', 'New York', 300, 60, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (20, 'Tower A', 'Chicago', 400, 80, 'Under Construction');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (30, 'Unmatched Building', 'Boston', 200, 40, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Beta Corp', 'Chicago', 'Tech', 50.5, 10.2, 100.0, '200.5');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'Alpha Inc', 'New York', 'Finance', 120.0, 25.0, 500.0, '450.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Unmatched Company', 'Boston', 'Retail', 10.0, 1.0, 20.0, '15.0');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (10, 1, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (20, 1, 2018);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (10, 2, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value_billion AS market_value_billion, RHS.id AS id_other, RHS.name AS name_other, RHS.city AS city, RHS.height AS height, RHS.stories AS stories, RHS.status AS status, RHS.move_in_year AS move_in_year, RHS.building_id AS building_id FROM companies AS LHS INNER JOIN (SELECT id, name, city, height, stories, status, company_id, move_in_year, id AS building_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.city AS city, LHS.height AS height, LHS.stories AS stories, LHS.status AS status, RHS.company_id AS company_id, RHS.move_in_year AS move_in_year FROM buildings AS LHS INNER JOIN office_locations AS RHS ON (LHS.id = RHS.building_id))) AS RHS ON (LHS.id = RHS.company_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Alpha Inc', 'Tower B')
('Beta Corp', 'Tower A')
('Beta Corp', 'Tower B')
*/

-- Prediction Query
SELECT T3.name, T2.name FROM Office_locations AS T1 JOIN buildings AS T2 ON T1.building_id = T2.id JOIN Companies AS T3 ON T1.company_id = T3.id;

/*
Prediction Result:
('Beta Corp', 'Tower B')
('Alpha Inc', 'Tower B')
('Beta Corp', 'Tower A')
*/