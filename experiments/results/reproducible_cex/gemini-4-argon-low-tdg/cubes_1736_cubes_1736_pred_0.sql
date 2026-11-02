-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 30, 'Alice', 'USA', 'MIT');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 30, 'Bob', 'USA', 'Stanford');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (3, 30, 'Charlie', 'UK', 'Oxford');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (4, 40, 'David', 'USA', 'Harvard');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (5, 40, 'Eve', 'USA', 'Yale');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (6, 40, 'Frank', 'USA', 'Princeton');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1.0, 'TechCorp', 'NY', 'Tech', 10.0, 2.0, 50.0, 100.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (2.0, 'AlphaInc', 'CA', 'Finance', 20.0, 5.0, 80.0, 200.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (3.0, 'GhostLLC', 'TX', 'Retail', 5.0, 1.0, 10.0, 25.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 1, 5);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 2, 3);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (2, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, n AS count___ FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.age AS age, RHS.nationality AS nationality, RHS.n AS n FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.people_id AS people_id, RHS.year_working AS year_working FROM company AS LHS INNER JOIN employment AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS CROSS JOIN (SELECT age, nationality, COUNT(*) AS n FROM people GROUP BY age, nationality) AS RHS) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('AlphaInc', 1)
('AlphaInc', 2)
('AlphaInc', 3)
('TechCorp', 1)
('TechCorp', 2)
('TechCorp', 3)
*/

-- Prediction Query
SELECT T3.Name, COUNT(*) FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID GROUP BY T3.Name;

/*
Prediction Result:
('AlphaInc', 1)
('TechCorp', 2)
*/