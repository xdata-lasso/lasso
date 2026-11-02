-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 45, 'David', 'Swiss', 'ETH');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 38, 'Eva', 'Dutch', 'Delft');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1, 'ZCorp1', 'Zurich', 'Finance', 50.0, 10.0, 100.0, 80.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (2, 'ZCorp2', 'Zurich', 'Pharma', 60.0, 12.0, 110.0, 90.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (3, 'ZCorp3', 'Zurich', 'Tech', 40.0, 8.0, 90.0, 70.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (4, 'LCorp1', 'London', 'Finance', 300.0, 50.0, 600.0, 500.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (5, 'LCorp2', 'London', 'Retail', 250.0, 45.0, 500.0, 450.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (6, 'ACorp1', 'Amsterdam', 'Logistics', 20.0, 3.0, 40.0, 30.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (7, 'ACorp2', 'Amsterdam', 'Energy', 25.0, 4.0, 50.0, 35.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (8, 'ACorp3', 'Amsterdam', 'Retail', 15.0, 2.0, 30.0, 25.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (9, 'MCorp1', 'Madrid', 'Telecom', 900.0, 200.0, 1500.0, 1200.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (4, 1, 12);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (4, 2, 7);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (9, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT LHS.n AS n, RHS.headquarters AS headquarters, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters)) AS LHS CROSS JOIN (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters) AS RHS) WHERE (n <= n_other) ORDER BY headquarters;

/*
Gold Result:
('Amsterdam',)
('Zurich',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('Amsterdam',)
*/