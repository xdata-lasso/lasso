-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by school_name, tie-breaking by school_id, NULLS LAST behavior on school_id, and distinctly named columns (Location vs County, Mascot vs IHSAA_Class)
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('2', 'Beta High', 'Northtown', 'Tigers', 1200, '4A', '4A', 'North County');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('10', 'Alpha High', 'Eastville', 'Eagles', 500, '2A', '2A', 'East County');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'Alpha High', 'Westville', 'Hawks', 800, '3A', '3A', 'West County');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES (NULL, 'Alpha High', 'Southville', 'Falcons', 600, '2A', '2A', 'South County');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name, LOCATION, mascot FROM school ORDER BY school_name, school.school_id NULLS LAST;

/*
Gold Result:
('Alpha High', 'Westville', 'Hawks')
('Alpha High', 'Eastville', 'Eagles')
('Alpha High', 'Southville', 'Falcons')
('Beta High', 'Northtown', 'Tigers')
*/

-- Prediction Query
SELECT school_name, LOCATION, mascot FROM school;

/*
Prediction Result:
('Beta High', 'Northtown', 'Tigers')
('Alpha High', 'Eastville', 'Eagles')
('Alpha High', 'Westville', 'Hawks')
('Alpha High', 'Southville', 'Falcons')
*/