-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (30.5, 'CompA', 'Boston', 'Tech', 10.0, 2.0, 50.0, 100.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (10.2, 'CompB', 'Boston', 'Finance', 20.0, 4.0, 60.0, 120.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (20.1, 'CompC', 'Austin', 'Retail', 5.0, 1.0, 10.0, 30.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (5.0, 'CompD', 'Chicago', 'Energy', 15.0, 3.0, 40.0, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters, industry FROM company ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
('Austin', 'Retail')
('Boston', 'Finance')
('Boston', 'Tech')
('Chicago', 'Energy')
*/

-- Prediction Query
SELECT Headquarters, Industry FROM company;

/*
Prediction Result:
('Boston', 'Tech')
('Boston', 'Finance')
('Austin', 'Retail')
('Chicago', 'Energy')
*/