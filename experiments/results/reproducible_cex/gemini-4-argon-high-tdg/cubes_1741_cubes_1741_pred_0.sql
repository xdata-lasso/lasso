-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (1, 45, 'Alice Smith', 'USA', 'Harvard');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (2, 38, 'Bob Jones', 'UK', 'Oxford');
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1, 'Apex Corp', 'Zurich', 'Banking', 10.5, 1.2, 100.0, 50.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2, 'Beacon Ltd', 'London', 'Banking', 25.0, 3.4, 250.0, 80.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3, 'Citadel Financial', 'London', 'Banking', 30.0, 4.1, 300.0, 95.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (4, 'Delta Bank', 'Amsterdam', 'Banking', 50.0, 6.0, 500.0, 120.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (5, 'PetroMax', 'Houston', 'Oil and gas', 80.0, 10.0, 400.0, 200.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (6, 'TechNova', 'San Francisco', 'Technology', 60.0, 12.0, 150.0, 300.0);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (2, 1, 5);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (2, 2, 3);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (5, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "headquarters" FROM "company" WHERE ("industry" = 'Banking' AND "industry" <> 'Oil and gas') ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('Amsterdam',)
('London',)
('Zurich',)
*/

-- Prediction Query
SELECT Headquarters FROM company WHERE Industry = 'Banking' INTERSECT SELECT Headquarters FROM company WHERE Industry = 'Oil and gas';

/*
Prediction Result:
*/