-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('1', 'Beta High', 'Alpha City', 'Aces', 100, '2A', '1A', 'Adams');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('2', 'Central High', 'Zeta City', 'Tigers', 500, '1A', '4A', 'Wayne');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('3', 'Gamma High', 'Beta City', 'Bears', 1000, '4A', '2A', 'Allen');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (1, 2020, 50000, 50.0, 25000, 50.0, '50%');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (3, 2020, 50000, 50.0, 25000, 50.0, '50%');
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (1, 1, 'Alice Smith', 10000.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (2, 3, 'Bob Jones', 20000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT * FROM (SELECT * FROM school ORDER BY ihsaa_class, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Central High',)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta High',)
*/