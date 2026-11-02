-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering, duplicate Name values (to catch DISTINCT mutants), and tie-breaking by Company_ID vs other columns.
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3.0, 'Zeta Corp', 'NY', 'Tech', 10.5, 2.0, 50.0, 100.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1.0, 'Alpha Inc', 'LA', 'Retail', 50.0, 5.0, 20.0, 80.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2.0, 'Alpha Inc', 'Chicago', 'Finance', 5.0, 1.0, 100.0, 200.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (4.0, 'Beta LLC', 'SF', 'Bio', 20.0, -1.0, 10.0, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM company ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT Name FROM company ORDER BY Sales_in_Billion ASC, company.company_id NULLS LAST;

/*
Prediction Result:
('Alpha Inc',)
('Zeta Corp',)
('Beta LLC',)
('Alpha Inc',)
*/