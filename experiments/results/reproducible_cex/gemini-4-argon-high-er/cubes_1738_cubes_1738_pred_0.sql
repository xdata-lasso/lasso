-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1.0, 'Acme', 'NY', 'Tech', 200.0, 10.0, 50.0, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM company WHERE (sales_in_billion >= 200.0) ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
('Acme',)
*/

-- Prediction Query
SELECT name FROM company WHERE Sales_in_Billion > 200 ORDER BY Sales_in_Billion, Profits_in_Billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
*/