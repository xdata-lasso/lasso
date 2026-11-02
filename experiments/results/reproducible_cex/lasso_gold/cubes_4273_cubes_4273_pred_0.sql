-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1001.5, 'Allison Hill', 'all', 'better', 1004.5, 1007.5, 1010.5, 1013.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1002.5, 'Noah Rhodes', 'all', 'discover', 1015.5, 1020.5, 1025.5, 1030.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1003.5, 'Angie Henderson', 'all', 'early', 1026.5, 1033.5, 1040.5, 1047.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1016.5, 'Alyssa Gonzalez', 'sure', 'collection', 1019.5, 1022.5, 1025.5, 1028.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1017.5, 'Kimberly Robinson', 'sure', 'save', 1030.5, 1035.5, 1040.5, 1045.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1018.5, 'Rhonda Smith', 'sure', 'knowledge', 1041.5, 1048.5, 1055.5, 1062.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT LHS.n AS n, RHS.headquarters AS headquarters, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters)) AS LHS CROSS JOIN (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters) AS RHS) WHERE (n <= n_other) ORDER BY headquarters;

/*
Gold Result:
('all',)
('sure',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('all',)
*/