-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion) VALUES (0.0, 'default1', 'default1', NULL, 1.0, 0.0, 1.0, 0.0), (1.0, 'default1', 'default1', NULL, 1.0, 1.0, 0.0, NULL), (100000.0, NULL, NULL, NULL, 1.0, NULL, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters, industry FROM company ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
(None, None)
('default1', None)
('default1', None)
*/

-- Prediction Query
SELECT Headquarters, Industry FROM company;

/*
Prediction Result:
('default1', None)
('default1', None)
(None, None)
*/