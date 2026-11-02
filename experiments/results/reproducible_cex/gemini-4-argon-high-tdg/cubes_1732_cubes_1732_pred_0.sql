-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 35, 'Alice Smith', 'USA', 'MIT');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 42, 'Bob Jones', 'Germany', 'TUM');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1, 'Alpha Corp', 'New York', 'Automotive', 10.0, 50.0, 100.0, 200.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (2, 'Beta Inc', 'London', 'Banking', 50.0, 10.0, 500.0, 600.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (3, 'Gamma Ltd', 'Berlin', 'Technology', 90.0, 80.0, 900.0, 1000.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 1, 5);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (3, 2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT * FROM (SELECT * FROM (SELECT company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion, COUNT(*) OVER () AS n FROM company) ORDER BY profits_in_billion) LIMIT 1);

/*
Gold Result:
('London',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('Berlin',)
*/