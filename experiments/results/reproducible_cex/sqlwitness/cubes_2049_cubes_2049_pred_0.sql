-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO endowment (endowment_id, school_id, donator_name, amount) VALUES (1, NULL, 'default1', 1.0), (0, NULL, 'default1', 1.0), (2, NULL, 'default2', 0.0), (3, NULL, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT donator_name FROM endowment;

/*
Prediction Result:
('default1',)
('default2',)
(None,)
*/