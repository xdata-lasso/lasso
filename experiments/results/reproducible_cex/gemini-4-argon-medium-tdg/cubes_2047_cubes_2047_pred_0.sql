-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in ORDER BY (NULLS FIRST vs NULLS LAST on both school_name and school_id) and NULLs in projected columns.
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES (NULL, 'Delta High', 'City D', 'Bears', 600, '2A', '2A', 'County W');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('5', 'Delta High', NULL, 'Lions', 700, '3A', '3A', 'County W');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('3', NULL, 'City E', NULL, 400, '1A', '1A', 'County V');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'Gamma High', 'City G', 'Hawks', 900, '3A', '3A', 'County U');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name, LOCATION, mascot FROM school ORDER BY school_name, school.school_id NULLS LAST;

/*
Gold Result:
(None, 'City E', None)
('Delta High', None, 'Lions')
('Delta High', 'City D', 'Bears')
('Gamma High', 'City G', 'Hawks')
*/

-- Prediction Query
SELECT school_name, LOCATION, mascot FROM school;

/*
Prediction Result:
('Delta High', 'City D', 'Bears')
('Delta High', None, 'Lions')
(None, 'City E', None)
('Gamma High', 'City G', 'Hawks')
*/