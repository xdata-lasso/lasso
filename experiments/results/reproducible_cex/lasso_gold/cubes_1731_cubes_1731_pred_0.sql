-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1061.5, 'Darren Roberts', 'fall', 'Banking', 1063.5, 1065.5, 1067.5, 1069.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1062.5, 'David Garcia', 'long', 'Retailing', 1074.5, 1078.5, 1082.5, 1086.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1071.5, 'Holly Wood', 'raise', 'Banking', 1073.5, 1075.5, 1077.5, 1079.5);
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1072.5, 'Derek Zuniga', 'away', 'Retailing', 1084.5, 1088.5, 1092.5, 1096.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "company" WHERE ("industry" = 'Banking' OR "industry" = 'Retailing') ORDER BY name, company.company_id NULLS LAST;

/*
Gold Result:
('Darren Roberts',)
('David Garcia',)
('Derek Zuniga',)
('Holly Wood',)
*/

-- Prediction Query
SELECT Name FROM company WHERE Industry = 'Banking' OR Industry = 'Retailing';

/*
Prediction Result:
('Darren Roberts',)
('David Garcia',)
('Holly Wood',)
('Derek Zuniga',)
*/