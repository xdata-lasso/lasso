-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (1, 35, 'Alice Smith', 'USA', 'MIT');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (2, 42, 'Bob Jones', 'UK', 'Oxford');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (3, 29, 'Carol White', 'Canada', 'Toronto');
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1, 'Charlie Corp', 'Zurich', 'Tech', 50.0, 10.0, 200.0, 300.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2, 'Alpha Inc', 'Boston', 'Finance', 100.0, 5.0, 500.0, 100.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3, 'Delta LLC', 'London', 'Energy', 10.0, 25.0, 50.0, 400.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (4, 'Bravo Ltd', 'Austin', 'Retail', 75.0, 15.0, 100.0, 200.0);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (1, 1, 5);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (1, 2, 3);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (2, 3, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM company ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Bravo Ltd',)
('Charlie Corp',)
('Delta LLC',)
*/

-- Prediction Query
SELECT Name FROM company ORDER BY Sales_in_Billion ASC, company.company_id NULLS LAST;

/*
Prediction Result:
('Delta LLC',)
('Charlie Corp',)
('Bravo Ltd',)
('Alpha Inc',)
*/