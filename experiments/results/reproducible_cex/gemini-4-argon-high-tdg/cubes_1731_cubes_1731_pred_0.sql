-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (1, 35, 'Alice Smith', 'USA', 'MIT');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (2, 42, 'Bob Jones', 'UK', 'Oxford');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (3, 29, 'Charlie Brown', 'Canada', 'Toronto');
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1.0, 'Zeta Corp', 'New York', 'Banking', 120.5, 15.2, 950.0, 210.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2.0, 'Beta Retail', 'London', 'Retailing', 85.0, 8.5, 60.0, 110.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3.0, 'Alpha Bank', 'Tokyo', 'Banking', 200.0, 25.0, 1500.0, 300.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (4.0, 'Omega Tech', 'San Francisco', 'Technology', 300.0, 50.0, 400.0, 1200.0);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (2, 1, 5);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (2, 2, 3);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (3, 3, 7);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (4, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "company" WHERE ("industry" = 'Banking' OR "industry" = 'Retailing') ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha Bank',)
('Beta Retail',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT Name FROM company WHERE Industry = 'Banking' OR Industry = 'Retailing';

/*
Prediction Result:
('Zeta Corp',)
('Beta Retail',)
('Alpha Bank',)
*/