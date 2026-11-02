-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('remain', 'Jessica Holmes', '50983 Adrian Station
East Carloston, VI 43810', 'avoid', 1016, 'my', 'economy', 'family');
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1017, 'remain', 'Cindy Anderson', 9.0);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1018, 'remain', 'Cindy Anderson', 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment WHERE (amount >= 9.0) ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Cindy Anderson',)
('Cindy Anderson',)
*/

-- Prediction Query
SELECT donator_name FROM endowment EXCEPT SELECT donator_name FROM endowment WHERE amount < 9;

/*
Prediction Result:
('Cindy Anderson',)
*/