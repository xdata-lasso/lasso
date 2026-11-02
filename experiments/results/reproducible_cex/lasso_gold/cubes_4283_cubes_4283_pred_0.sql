-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1239.5, 'Dr. Steven Martin', 'message', 'clear', NULL, 1244.5, 1248.5, 1252.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1240.5, 'James House', 'message', 'fine', NULL, 1257.5, 1263.5, 1269.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1241.5, 'Dominique Horton', 'message', 'director', NULL, 1270.5, 1278.5, 1286.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1242.5, 'Rachel Stanley', 'message', 'article', NULL, 1283.5, 1293.5, 1303.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1256.5, 'Kimberly Adkins', 'Republican', 'training', NULL, 1261.5, 1265.5, 1269.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1257.5, 'Kevin Shaw', 'Republican', 'easy', NULL, 1274.5, 1280.5, 1286.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1258.5, 'Brooke Yu', 'Republican', 'international', NULL, 1287.5, 1295.5, 1303.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1259.5, 'Cody Larson', 'Republican', 'call', NULL, 1300.5, 1310.5, 1320.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT * FROM (SELECT * FROM (SELECT headquarters, sales_in_billion, MAX(sales_in_billion) AS maxsales_in_billion FROM company GROUP BY headquarters, sales_in_billion) ORDER BY sales_in_billion DESC) LIMIT 1);

/*
Gold Result:
('Republican',)
*/

-- Prediction Query
SELECT Headquarters FROM company ORDER BY Sales_in_Billion DESC, company.company_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('message',)
*/