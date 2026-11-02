-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "School" ("School_id", "School_name") VALUES ('1', 'Central High');
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (1, 1, 'Alice', 10.0);
INSERT INTO "endowment" ("endowment_id", "School_id", "donator_name", "amount") VALUES (2, 1, 'Alice', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment WHERE (amount >= 9.0) ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT donator_name FROM endowment EXCEPT SELECT donator_name FROM endowment WHERE amount < 9;

/*
Prediction Result:
*/