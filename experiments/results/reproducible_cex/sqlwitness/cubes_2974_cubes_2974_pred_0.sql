-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO companies (id, name, headquarters, industry, sales_billion, profits_billion, assets_billion, market_value_billion) VALUES (0, 'default1', 'default2', NULL, 1.0, 1.0, 0.0, NULL), (1, 'default2', 'default1', 'default2', NULL, 1.0, 1.0, 'default1'), (2, NULL, 'default1', 'default2', 1.0, NULL, 1.0, 'default1'), (3, NULL, NULL, NULL, NULL, 1.0, 1.0, NULL);
INSERT INTO buildings (id, name, city, height, stories, status) VALUES (0, 'default2', 'default2', NULL, 1, 'default2'), (1, 'default2', NULL, 1, 0, 'default1'), (2, 'default1', 'default1', 1, NULL, 'default1'), (3, NULL, 'default1', 0, NULL, 'default2'), (4, 'default1', NULL, NULL, 1, NULL), (5, 'default1', 'default2', NULL, 1, NULL), (6, 'default1', 'default2', 0, 0, 'default1');
INSERT INTO office_locations (building_id, company_id, move_in_year) VALUES (1, 0, 1), (4, 3, 0), (4, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value_billion AS market_value_billion, RHS.id AS id_other, RHS.name AS name_other, RHS.city AS city, RHS.height AS height, RHS.stories AS stories, RHS.status AS status, RHS.move_in_year AS move_in_year, RHS.building_id AS building_id FROM companies AS LHS INNER JOIN (SELECT id, name, city, height, stories, status, company_id, move_in_year, id AS building_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.city AS city, LHS.height AS height, LHS.stories AS stories, LHS.status AS status, RHS.company_id AS company_id, RHS.move_in_year AS move_in_year FROM buildings AS LHS INNER JOIN office_locations AS RHS ON (LHS.id = RHS.building_id))) AS RHS ON (LHS.id = RHS.company_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default1')
('default1', 'default2')
*/

-- Prediction Query
SELECT T3.name, T2.name FROM Office_locations AS T1 JOIN buildings AS T2 ON T1.building_id = T2.id JOIN Companies AS T3 ON T1.company_id = T3.id;

/*
Prediction Result:
('default1', 'default2')
('default1', 'default1')
(None, 'default1')
*/