-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the minimum enrollment, ordering by school_name, and kills LIMIT 1 or MAX() mutants.
-- Also includes schools with no budget or endowment records to kill unnecessary INNER JOIN mutants.
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'Zeta High', 'LocA', 'Tigers', 150, '1A', '1A', 'CountyA');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('2', 'Alpha High', 'LocB', 'Bears', 150, '1A', '1A', 'CountyB');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('3', 'Beta High', 'LocC', 'Lions', 300, '2A', '2A', 'CountyC');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('4', 'Omega High', 'LocD', 'Eagles', 500, '3A', '3A', 'CountyD');
INSERT INTO "budget" ("School_id", "Year", "Budgeted", "total_budget_percent_budgeted", "Invested", "total_budget_percent_invested", "Budget_invested_percent") VALUES (3, 2020, 10000, 50.0, 5000, 50.0, '50%');
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (101, 4, 'John Doe', 25000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT LHS.enrollment AS enrollment, RHS.school_id AS school_id, RHS.school_name AS school_name, RHS.location AS LOCATION, RHS.mascot AS mascot, RHS.ihsaa_class AS ihsaa_class, RHS.ihsaa_football_class AS ihsaa_football_class, RHS.county AS county FROM (SELECT MIN(enrollment) AS enrollment FROM school) AS LHS LEFT JOIN school AS RHS ON (LHS.enrollment = RHS.enrollment)) ORDER BY school_name;

/*
Gold Result:
('Alpha High',)
('Zeta High',)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta High',)
*/