-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('animal', 'Michelle Lewis', '76483 Cameron Trail
East Lydiamouth, MO 35594', 'attorney', 1003, 'determine', 'religious', 'example');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('science', 'Kimberly Dudley', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear', 1004, 'development', 'white', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name, LOCATION, mascot FROM school ORDER BY school_name, school.school_id NULLS LAST;

/*
Gold Result:
('Kimberly Dudley', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021', 'hear')
('Michelle Lewis', '76483 Cameron Trail\nEast Lydiamouth, MO 35594', 'attorney')
*/

-- Prediction Query
SELECT school_name, LOCATION, mascot FROM school;

/*
Prediction Result:
('Michelle Lewis', '76483 Cameron Trail\nEast Lydiamouth, MO 35594', 'attorney')
('Kimberly Dudley', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021', 'hear')
*/