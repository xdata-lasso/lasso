-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1069, 'Kevin Hurst', 'four', 'institution', 1070.5, 1071.5, 1072.5, 1073.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1077, 'Crystal Johnson', 'who', 'question', 1071.5, 1072.5, 1073.5, 1074.5);
INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (1074, 1075, 'Daniel Bright', 'Turkey', 'serious');
INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (1082, 1083, 'Daniel Hahn', 'Monaco', 'nothing');
INSERT INTO "employment" ("company_id", "people_id", "year_working") VALUES (1069, 1074, 1076);
INSERT INTO "employment" ("company_id", "people_id", "year_working") VALUES (1077, 1082, 1084);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.people_id AS people_id, LHS.age AS age, LHS.name AS name, LHS.nationality AS nationality, LHS.graduation_college AS graduation_college, RHS.company_id AS company_id, RHS.name AS name_other, RHS.headquarters AS headquarters, RHS.industry AS industry, RHS.sales_in_billion AS sales_in_billion, RHS.profits_in_billion AS profits_in_billion, RHS.assets_in_billion AS assets_in_billion, RHS.market_value_in_billion AS market_value_in_billion, RHS.year_working AS year_working FROM people AS LHS INNER JOIN (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.people_id AS people_id, RHS.year_working AS year_working FROM company AS LHS INNER JOIN employment AS RHS ON (LHS.company_id = RHS.company_id)) AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Crystal Johnson', 'Daniel Hahn')
('Kevin Hurst', 'Daniel Bright')
*/

-- Prediction Query
SELECT T3.Name, T2.Name FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID;

/*
Prediction Result:
('Kevin Hurst', 'Daniel Bright')
('Crystal Johnson', 'Daniel Hahn')
*/