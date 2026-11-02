-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion) VALUES (0.0, 'default2', 'default1', 'Retailing', 0.0, 1.0, 0.0, NULL), (1.0, NULL, 'default1', NULL, NULL, NULL, 1.0, 0.0), (14285.714286, NULL, 'default2', 'default2', 0.0, 0.0, NULL, NULL), (28571.428571, 'default2', 'default2', 'default1', 0.0, NULL, 0.0, 0.0), (42857.142857, NULL, 'Banking', 'default2', 0.0, 1.0, NULL, 1.0), (57142.857143, 'default1', 'default2', 'default1', 1.0, 0.0, 0.0, NULL), (71428.571429, 'Banking', NULL, 'default1', 0.0, 1.0, 0.0, NULL), (85714.285714, 'Retailing', 'Retailing', 'Retailing', 0.0, 1.0, NULL, NULL), (100000.0, NULL, 'default1', 'Banking', NULL, 0.0, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "company" WHERE ("industry" = 'Banking' OR "industry" = 'Retailing') ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
(None,)
('Retailing',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM company WHERE Industry = 'Banking' OR Industry = 'Retailing';

/*
Prediction Result:
('default2',)
('Retailing',)
(None,)
*/