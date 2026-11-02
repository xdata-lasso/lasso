-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), and anti-correlated column ordering (donator_name vs amount vs School_id).
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'Central High', 'City A', 'Eagles', 1200, '4A', '4A', 'County X');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('2', 'North High', 'City B', 'Tigers', 800, '3A', '3A', 'County Y');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('3', 'South High', 'City C', 'Bears', 500, '2A', '2A', 'County Z');
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (1, 3, 'Charlie', 100.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (2, 1, 'Alice', 500.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (3, 2, 'Bob', 300.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (4, 1, 'Alice', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT DISTINCT donator_name FROM endowment;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Bob',)
*/