-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'School A', 'City A', 'Eagles', 1000, '4A', '4A', 'County A');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('2', 'School B', 'City B', 'Tigers', 800, '3A', '3A', 'County B');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('3', 'School C', 'City C', 'Bears', 600, '2A', '2A', 'County C');
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (1, 1, 'Alice', 100.5);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (2, 1, 'Alice', 200.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (3, 2, 'Alice', 50.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (4, 1, 'Bob', 500.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (5, 2, 'Bob', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name, sumamount AS sum_amount_ FROM (SELECT donator_name, school_id, SUM(amount) AS sumamount FROM endowment GROUP BY donator_name, school_id) ORDER BY donator_name, sum_amount_ NULLS LAST;

/*
Gold Result:
('Alice', 50.0)
('Alice', 300.5)
('Bob', 500.0)
('Bob', 500.0)
*/

-- Prediction Query
SELECT donator_name, SUM(amount) FROM endowment GROUP BY donator_name ORDER BY SUM(amount) DESC, donator_name NULLS LAST;

/*
Prediction Result:
('Bob', 1000.0)
('Alice', 350.5)
*/