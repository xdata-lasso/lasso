-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('table', 'Olivia Moore', '35116 Michael Key Suite 078
South Christianport, MP 82898', 'present', 1004, 'value', 'training', 'high');
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1005, 'table', 'Michele Williams', 1006.5);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1007, 'table', 'Michele Williams', 1006.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Michele Williams',)
('Michele Williams',)
*/

-- Prediction Query
SELECT DISTINCT donator_name FROM endowment;

/*
Prediction Result:
('Michele Williams',)
*/