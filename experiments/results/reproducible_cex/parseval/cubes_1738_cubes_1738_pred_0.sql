-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: company --
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1.0, 'com_0c26d3', '5k5swwqcgs', '9n8', 200.0, 874.871895, 475.173408, 935.695299);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (2.0, 'com_0c26d3', 'u7vfe4hria2y', 'uzhs', 200.0, 663.049759, 711.020062, 944.247544);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM company WHERE (sales_in_billion >= 200.0) ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
('com_0c26d3',)
('com_0c26d3',)
*/

-- Prediction Query
SELECT name FROM company WHERE Sales_in_Billion > 200 ORDER BY Sales_in_Billion, Profits_in_Billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
*/