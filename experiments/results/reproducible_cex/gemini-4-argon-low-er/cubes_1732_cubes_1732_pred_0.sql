-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1.0, 'Corp A', 'City A', 'Tech', 10.0, 1.0, 10.0, 10.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2.0, 'Corp B', 'City B', 'Tech', 10.0, 5.0, 10.0, 10.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (3.0, 'Corp C', 'City B', 'Tech', 10.0, 10.0, 10.0, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT * FROM (SELECT * FROM (SELECT company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion, COUNT(*) OVER () AS n FROM company) ORDER BY profits_in_billion) LIMIT 1);

/*
Gold Result:
('City A',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('City B',)
*/