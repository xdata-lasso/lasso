-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 34, 'Alice Smith', 'USA', 'MIT');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 45, 'Bob Jones', 'UK', 'Oxford');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (3, 29, 'Carol White', 'Canada', 'Toronto');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (4, 52, 'David Brown', 'USA', 'Stanford');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (20.0, 'Omega Corp', 'New York', 'Banking', 50.5, 10.2, 200.0, 150.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (5.0, 'Alpha Inc', 'New York', 'Technology', 120.0, 25.0, 300.0, 500.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (15.0, 'Beta LLC', 'Austin', 'Energy', 80.0, -2.5, 110.0, 60.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (30.0, 'Gamma Ltd', 'New York', 'Banking', 15.0, 1.5, 40.0, 35.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (2.0, 'Delta Co', 'Austin', 'Retail', 95.0, 8.0, 75.0, 90.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (20, 1, 5);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (20, 2, 12);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (5, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters, industry FROM company ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
('Austin', 'Retail')
('Austin', 'Energy')
('New York', 'Technology')
('New York', 'Banking')
('New York', 'Banking')
*/

-- Prediction Query
SELECT Headquarters, Industry FROM company;

/*
Prediction Result:
('New York', 'Banking')
('New York', 'Technology')
('Austin', 'Energy')
('New York', 'Banking')
('Austin', 'Retail')
*/