-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'Central High', 'City A', 'Tigers', 1200, '4A', '4A', 'County X');
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (10, 1, 'Zack', 100.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (20, 1, 'Alice', 500.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (15, 1, 'Alice', 250.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (5, 1, 'Bob', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT donator_name FROM endowment;

/*
Prediction Result:
('Bob',)
('Zack',)
('Alice',)
*/