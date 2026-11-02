-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "School" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('17', NULL, '18', '19', -636, '20', '21', '22');
INSERT INTO "School" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('9', NULL, '-636', '-636', -635, '-636', '-636', '-636');
INSERT INTO "budget" ("school_id", "year", "budgeted", "total_budget_percent_budgeted", "invested", "total_budget_percent_invested", "budget_invested_percent") VALUES (9, 11, -636, -636, -636, -636, '-636');
INSERT INTO "budget" ("school_id", "year", "budgeted", "total_budget_percent_budgeted", "invested", "total_budget_percent_invested", "budget_invested_percent") VALUES (9, 10, -636, -636, -636, -636, '-636');
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (13, '17', '-636', -636);
INSERT INTO "endowment" ("endowment_id", "school_id", "donator_name", "amount") VALUES (12, '9', '-636', -636);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT LHS.enrollment AS enrollment, RHS.school_id AS school_id, RHS.school_name AS school_name, RHS.location AS LOCATION, RHS.mascot AS mascot, RHS.ihsaa_class AS ihsaa_class, RHS.ihsaa_football_class AS ihsaa_football_class, RHS.county AS county FROM (SELECT MIN(enrollment) AS enrollment FROM school) AS LHS LEFT JOIN school AS RHS ON (LHS.enrollment = RHS.enrollment)) ORDER BY school_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/