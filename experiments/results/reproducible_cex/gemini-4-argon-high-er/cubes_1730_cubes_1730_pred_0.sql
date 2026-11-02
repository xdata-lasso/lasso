-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 30, 'Alice', 'USA', 'MIT');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1, 'Acme', 'NY', 'Tech', 200.0, 10.0, 50.0, 100.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name FROM (SELECT LHS.company_id AS company_id, LHS.people_id AS people_id, LHS.year_working AS year_working, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.age AS age, RHS.name AS name_other, RHS.nationality AS nationality, RHS.graduation_college AS graduation_college FROM (SELECT LHS.company_id AS company_id, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.name AS name, RHS.headquarters AS headquarters, RHS.industry AS industry, RHS.sales_in_billion AS sales_in_billion, RHS.profits_in_billion AS profits_in_billion, RHS.assets_in_billion AS assets_in_billion, RHS.market_value_in_billion AS market_value_in_billion FROM employment AS LHS LEFT JOIN company AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) WHERE (sales_in_billion >= 200.0) ORDER BY name;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT T2.Name FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID WHERE T3.Sales_in_Billion > 200;

/*
Prediction Result:
*/