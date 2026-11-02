-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1018, 'Olivia Moore', 'knowledge', 'grow', 1019.5, 1020.5, 1021.5, NULL);
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1022, 'Phillip Garcia', 'husband', 'bill', 1023.5, 1024.5, 1025.5, 'her');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM companies ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Olivia Moore',)
('Phillip Garcia',)
*/

-- Prediction Query
SELECT name FROM Companies ORDER BY Market_Value_billion DESC, Companies.id NULLS LAST;

/*
Prediction Result:
('Phillip Garcia',)
('Olivia Moore',)
*/