-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in both Name and Company_ID (SQLite allows NULL in REAL PRIMARY KEY), killing mutants that alter NULLS FIRST/LAST or filter out NULLs.
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2.0, 'Beta', 'London', 'Tech', 15.0, 2.0, 30.0, 50.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (NULL, 'Alpha', 'Paris', 'Food', 5.0, 0.5, 10.0, 12.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1.0, 'Alpha', 'Berlin', 'Auto', 25.0, 3.0, 50.0, 80.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3.0, NULL, 'Tokyo', 'Games', 8.0, 1.0, 15.0, 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM company ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Beta',)
*/

-- Prediction Query
SELECT Name FROM company ORDER BY Sales_in_Billion ASC, company.company_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
(None,)
('Beta',)
('Alpha',)
*/