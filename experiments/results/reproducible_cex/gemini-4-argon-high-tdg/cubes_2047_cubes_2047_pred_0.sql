-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('2', 'Central High', 'Adams', 'Ants', 1200, '4A', '4A', 'Marion');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'Central High', 'Zion', 'Zebras', 850, '3A', '3A', 'Lake');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('3', 'Alpha Academy', 'Midway', 'Mustangs', 500, '2A', '2A', 'Allen');
INSERT INTO "budget" ("School_id", "Year", "Budgeted", "total_budget_percent_budgeted", "Invested", "total_budget_percent_invested", "Budget_invested_percent") VALUES (1, 2021, 100000, 50.0, 80000, 40.0, '80%');
INSERT INTO "budget" ("School_id", "Year", "Budgeted", "total_budget_percent_budgeted", "Invested", "total_budget_percent_invested", "Budget_invested_percent") VALUES (1, 2022, 120000, 60.0, 90000, 45.0, '75%');
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (101, 1, 'John Doe', 5000.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (102, 1, 'Jane Smith', 15000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name, LOCATION, mascot FROM school ORDER BY school_name, school.school_id NULLS LAST;

/*
Gold Result:
('Alpha Academy', 'Midway', 'Mustangs')
('Central High', 'Zion', 'Zebras')
('Central High', 'Adams', 'Ants')
*/

-- Prediction Query
SELECT school_name, LOCATION, mascot FROM school;

/*
Prediction Result:
('Central High', 'Adams', 'Ants')
('Central High', 'Zion', 'Zebras')
('Alpha Academy', 'Midway', 'Mustangs')
*/