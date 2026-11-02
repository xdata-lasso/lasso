-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: school --
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('sch_5358da', 'sch_f3cdc7', 'sch_a59e6f', 'sch_57cceb', 1, 'sch_9f39f1', 'sch_442624', 'sch_af178f');

INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('sch_9bc4da', 'sch_b445e8', 'sch_bd5bd8', 'sch_0da935', 1, 'sch_a83b56', 'sch_7a4fe2', 'sch_50edc3');

INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('&', '5k5swwqcgs', '9n8', '4', -734455130, '!', '4h', 'ia2yp');

INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('+', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', -1576219117, 'a', '5u', 'w6kl');

INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('school_id_5', 'q_1_cc8fd7', 'a9', '00t5c4e', 1274489983, 'gce', '76nium52', 'zbuo4nrqrof');

INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('school_id_6', 'q_1_cc8fd7', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT * FROM (SELECT * FROM school ORDER BY ihsaa_class, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('uzhsrwbbp6lu',)
*/