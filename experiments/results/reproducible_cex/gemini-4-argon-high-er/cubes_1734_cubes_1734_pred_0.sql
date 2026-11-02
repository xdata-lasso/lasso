-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (Company_ID, Name, Headquarters, Industry) VALUES (1, 'CompB', 'B', 'Tech');
INSERT INTO company (Company_ID, Name, Headquarters, Industry) VALUES (2, 'CompA', 'A', 'Finance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters, industry FROM company ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
('A', 'Finance')
('B', 'Tech')
*/

-- Prediction Query
SELECT Headquarters, Industry FROM company;

/*
Prediction Result:
('B', 'Tech')
('A', 'Finance')
*/