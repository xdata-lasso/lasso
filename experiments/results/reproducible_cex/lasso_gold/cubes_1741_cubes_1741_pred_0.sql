-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1001.5, 'Allison Hill', 'dog', 'Banking', 1002.5, 1003.5, 1004.5, 1005.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "headquarters" FROM "company" WHERE ("industry" = 'Banking' AND "industry" <> 'Oil and gas') ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('dog',)
*/

-- Prediction Query
SELECT Headquarters FROM company WHERE Industry = 'Banking' INTERSECT SELECT Headquarters FROM company WHERE Industry = 'Oil and gas';

/*
Prediction Result:
*/