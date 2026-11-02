-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "School" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('10', '13', '14', '15', NULL, '17', '18', '19');
INSERT INTO "School" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('9', '9403', '9403', '9403', 9403, '9403', '9403', '9403');
INSERT INTO "budget" ("school_id", "year", "budgeted", "total_budget_percent_budgeted", "invested", "total_budget_percent_invested", "budget_invested_percent") VALUES (10, 9403, 9403, 9403, 9403, 9403, '9403');
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (12, '9', '9403', 9403);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (11, '10', '9403', 9403);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(enrollment) OVER () AS sum_enrollment_, meanenrollment AS avg_enrollment_ FROM (SELECT school_id, school_name, LOCATION, mascot, enrollment, ihsaa_class, ihsaa_football_class, county, AVG(enrollment) OVER () AS meanenrollment FROM school) ORDER BY sum_enrollment_, avg_enrollment_ NULLS LAST;

/*
Gold Result:
(9403, 9403.0)
*/

-- Prediction Query
SELECT SUM(enrollment), AVG(enrollment) FROM school;

/*
Prediction Result:
(9403, 9403.0)
*/