-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('1', 'Zeta High', 'South Bend', 'Tigers', 200, '2A', '2A', 'St. Joseph');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('2', 'Alpha High', 'Fort Wayne', 'Eagles', 200, '2A', '2A', 'Allen');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('3', 'Beta High', 'Evansville', 'Panthers', NULL, '1A', '1A', 'Vanderburgh');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('4', 'Gamma High', 'Indianapolis', 'Bears', 800, '4A', '4A', 'Marion');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (1, 2021, 50000, 50.0, 25000, 50.0, '50%');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (1, 2022, 60000, 60.0, 30000, 50.0, '50%');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (4, 2022, 120000, 80.0, 90000, 75.0, '75%');
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (101, 1, 'John Smith', 15000.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (102, 1, 'Jane Doe', 25000.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (103, 4, 'Acme Corp', 100000.0);
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
('Beta High',)
*/