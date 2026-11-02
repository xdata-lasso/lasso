-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "School" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('11', '13', '13', '13', 13, '13', '13', '13');
INSERT INTO "School" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('6', '13', '13', '13', 13, '13', '13', '13');
INSERT INTO "budget" ("school_id", "year", "budgeted", "total_budget_percent_budgeted", "invested", "total_budget_percent_invested", "budget_invested_percent") VALUES (6, 8, 13, 13, 13, 13, '13');
INSERT INTO "budget" ("school_id", "year", "budgeted", "total_budget_percent_budgeted", "invested", "total_budget_percent_invested", "budget_invested_percent") VALUES (6, 7, 13, 13, 13, 13, '13');
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (10, '11', '13', -1);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (9, NULL, '13', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name, sumamount AS sum_amount_ FROM (SELECT donator_name, school_id, SUM(amount) AS sumamount FROM endowment GROUP BY donator_name, school_id) ORDER BY donator_name, sum_amount_ NULLS LAST;

/*
Gold Result:
('13', -1.0)
('13', -1.0)
*/

-- Prediction Query
SELECT donator_name, SUM(amount) FROM endowment GROUP BY donator_name ORDER BY SUM(amount) DESC, donator_name NULLS LAST;

/*
Prediction Result:
('13', -2.0)
*/