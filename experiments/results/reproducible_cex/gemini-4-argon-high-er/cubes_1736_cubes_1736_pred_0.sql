-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 30, 'Alice', 'US', 'MIT');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 40, 'Bob', 'UK', 'Oxford');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1, 'Google', 'US', 'Tech', 100.0, 10.0, 200.0, 500.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 1, 2020);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 2, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, n AS count___ FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.age AS age, RHS.nationality AS nationality, RHS.n AS n FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.people_id AS people_id, RHS.year_working AS year_working FROM company AS LHS INNER JOIN employment AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS CROSS JOIN (SELECT age, nationality, COUNT(*) AS n FROM people GROUP BY age, nationality) AS RHS) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Google', 1)
*/

-- Prediction Query
SELECT T3.Name, COUNT(*) FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID GROUP BY T3.Name;

/*
Prediction Result:
('Google', 2)
*/