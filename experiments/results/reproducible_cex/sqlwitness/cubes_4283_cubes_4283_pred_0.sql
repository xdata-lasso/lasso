-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion) VALUES (2.0, NULL, 'default1', 'default2', 1.0, 0.0, 0.0, 0.0), (1.0, 'default1', 'default1', 'default2', 2.0, NULL, 2.0, 0.0), (0.0, 'default2', NULL, 'default1', 1.0, NULL, NULL, 2.0), (12500.0, NULL, NULL, NULL, NULL, 2.0, NULL, 2.0), (25000.0, NULL, 'default1', 'default1', 1.0, 1.0, NULL, 2.0), (37500.0, NULL, 'default1', NULL, 0.0, 0.0, 1.0, 2.0), (50000.0, NULL, 'default2', 'default2', NULL, 2.0, 0.0, NULL), (62500.0, NULL, 'default2', 'default1', 2.0, 0.0, NULL, 2.0), (75000.0, NULL, NULL, 'default1', 0.0, 0.0, NULL, 2.0), (87500.0, 'default2', NULL, 'default2', 2.0, 2.0, 0.0, 0.0), (100000.0, 'default1', 'default1', NULL, 2.0, NULL, 0.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT * FROM (SELECT * FROM (SELECT headquarters, sales_in_billion, MAX(sales_in_billion) AS maxsales_in_billion FROM company GROUP BY headquarters, sales_in_billion) ORDER BY sales_in_billion DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Headquarters FROM company ORDER BY Sales_in_Billion DESC, company.company_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/