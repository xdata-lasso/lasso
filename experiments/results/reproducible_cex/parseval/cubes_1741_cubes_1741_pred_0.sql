-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: company --
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (2.0, '5k5swwqcgs', 'com_6702ae', 'Banking', 171.746906, 557.512061, 868.436572, 537.136345);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (3.0, '4', 'com_6702ae', 'Banking', 249.706432, 99.523333, 314.813297, 328.996339);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (582.588439, '5k5swwqcgsk', 'C', '9n8c4pgu7v', 86.520366, 65.761562, 779.409124, 640.719621);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (770.236508, 'ia2yp', 'A', 'uzhsrwbbp6lu', 737.440743, 334.878198, 55.194297, 303.05704);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "headquarters" FROM "company" WHERE ("industry" = 'Banking' AND "industry" <> 'Oil and gas') ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('com_6702ae',)
*/

-- Prediction Query
SELECT Headquarters FROM company WHERE Industry = 'Banking' INTERSECT SELECT Headquarters FROM company WHERE Industry = 'Oil and gas';

/*
Prediction Result:
*/