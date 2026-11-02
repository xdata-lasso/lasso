-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (1, 35, 'Alice', 'USA', 'MIT');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (2, 42, 'Bob', 'UK', 'Oxford');
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1, 'Bank A', 'New York', 'Banking', 100.0, 20.0, 500.0, 250.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2, 'Bank B', 'New York', 'Banking', 80.0, 15.0, 400.0, 200.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3, 'Bank C', 'London', 'Banking', 90.0, 18.0, 450.0, 220.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (4, 'Bank D', 'Tokyo', 'Banking', 70.0, 10.0, 350.0, 180.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (5, 'Oil Corp', 'Houston', 'Oil and gas', 200.0, 40.0, 600.0, 500.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (6, 'Tech Inc', 'San Francisco', 'Technology', 150.0, 35.0, 300.0, 800.0);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (1, 1, 5);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (5, 2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "headquarters" FROM "company" WHERE ("industry" = 'Banking' AND "industry" <> 'Oil and gas') ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('London',)
('New York',)
('Tokyo',)
*/

-- Prediction Query
SELECT Headquarters FROM company WHERE Industry = 'Banking' INTERSECT SELECT Headquarters FROM company WHERE Industry = 'Oil and gas';

/*
Prediction Result:
*/