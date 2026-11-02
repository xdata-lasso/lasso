-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion) VALUES (1.0, 'default1', NULL, NULL, NULL, 0.0, 0.0, NULL);
INSERT INTO people (people_id, age, name, nationality, graduation_college) VALUES (0, 0, 'default1', 'default2', 'default2'), (1, 0, NULL, 'default2', NULL);
INSERT INTO employment (company_id, people_id, year_working) VALUES (1.0, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, n AS count___ FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.age AS age, RHS.nationality AS nationality, RHS.n AS n FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.people_id AS people_id, RHS.year_working AS year_working FROM company AS LHS INNER JOIN employment AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS CROSS JOIN (SELECT age, nationality, COUNT(*) AS n FROM people GROUP BY age, nationality) AS RHS) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('default1', 2)
*/

-- Prediction Query
SELECT T3.Name, COUNT(*) FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID GROUP BY T3.Name;

/*
Prediction Result:
('default1', 1)
*/