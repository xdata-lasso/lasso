-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 45, 'Charlie', 'USA', 'MIT');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 38, 'Alice', 'UK', 'Oxford');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (3, 50, 'Bob', 'Canada', 'Toronto');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (4, 29, 'David', 'USA', 'Stanford');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (5, 41, 'Eve', 'France', 'Sorbonne');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (10, 'Zeta Corp', 'New York', 'Tech', 250.5, 40.0, 500.0, 800.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (20, 'Alpha Inc', 'London', 'Finance', 200.0, 25.0, 300.0, 450.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (30, 'Beta LLC', 'Toronto', 'Retail', 199.9, 15.0, 210.0, 300.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (40, 'Delta Co', 'San Jose', 'Energy', 0.0, 0.0, 100.0, 90.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (50, 'Epsilon SA', 'Paris', 'Media', NULL, 10.0, 150.0, 200.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (10, 1, 5);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (20, 2, 10);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (30, 3, 3);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (40, 4, 2);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (50, 5, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name FROM (SELECT LHS.company_id AS company_id, LHS.people_id AS people_id, LHS.year_working AS year_working, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.age AS age, RHS.name AS name_other, RHS.nationality AS nationality, RHS.graduation_college AS graduation_college FROM (SELECT LHS.company_id AS company_id, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.name AS name, RHS.headquarters AS headquarters, RHS.industry AS industry, RHS.sales_in_billion AS sales_in_billion, RHS.profits_in_billion AS profits_in_billion, RHS.assets_in_billion AS assets_in_billion, RHS.market_value_in_billion AS market_value_in_billion FROM employment AS LHS LEFT JOIN company AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) WHERE (sales_in_billion >= 200.0) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.Name FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID WHERE T3.Sales_in_Billion > 200;

/*
Prediction Result:
('Charlie',)
*/