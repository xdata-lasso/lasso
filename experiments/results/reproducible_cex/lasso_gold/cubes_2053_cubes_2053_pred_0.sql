-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('term', 'Ethan Adams', '76724 John Points Suite 969
Coxberg, NY 65187', 'benefit', 1012, 'someone', 'anyone', 'traditional');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('knowledge', 'Janice Carlson', '018 Mack Junctions Apt. 462
Smithview, NY 23917', 'movement', 1015, 'while', 'born', 'truth');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('theory', 'James Martin', 'USS George
FPO AA 03053', 'brother', 1018, 'woman', 'him', 'unit');
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1013, 'term', 'Mark Conner', 1014.5);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1016, 'knowledge', 'Sarah Romero', NULL);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1019, 'knowledge', 'Sarah Romero', 1020.5);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (1021, 'term', 'Mark Conner', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name, sumamount AS sum_amount_ FROM (SELECT donator_name, school_id, SUM(amount) AS sumamount FROM endowment GROUP BY donator_name, school_id) ORDER BY donator_name, sum_amount_ NULLS LAST;

/*
Gold Result:
('Mark Conner', 1014.5)
('Sarah Romero', 1020.5)
*/

-- Prediction Query
SELECT donator_name, SUM(amount) FROM endowment GROUP BY donator_name ORDER BY SUM(amount) DESC, donator_name NULLS LAST;

/*
Prediction Result:
('Sarah Romero', 1020.5)
('Mark Conner', 1014.5)
*/