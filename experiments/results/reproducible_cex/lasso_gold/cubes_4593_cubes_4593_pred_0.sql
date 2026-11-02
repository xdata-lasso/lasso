-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('serious', 'Matthew Foster', 'PSC 7242, Box 3884
APO AP 77123', 'later', 1005, 'water', 'past', 'inside');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('high', 'Zachary Hicks', '22691 James Mountain
Tashatown, TX 94967', 'building', 1006, 'rest', 'value', 'not');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('social', 'Zachary Hicks', '22691 James Mountain
Tashatown, TX 94967', 'building', 1006, 'rest', 'value', 'not');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('example', 'Gina Carter', '482 Monica Hills
East Nathaniel, GA 71198', 'start', NULL, 'win', 'nice', 'why');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('a', 'Katherine Rodriguez', '03911 Cabrera Trace Apt. 278
West Allison, PA 55962', 'development', NULL, 'woman', 'notice', 'someone');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('show', 'Katherine Rodriguez', '03911 Cabrera Trace Apt. 278
West Allison, PA 55962', 'development', NULL, 'woman', 'notice', 'someone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT LHS.enrollment AS enrollment, RHS.school_id AS school_id, RHS.school_name AS school_name, RHS.location AS LOCATION, RHS.mascot AS mascot, RHS.ihsaa_class AS ihsaa_class, RHS.ihsaa_football_class AS ihsaa_football_class, RHS.county AS county FROM (SELECT MIN(enrollment) AS enrollment FROM school) AS LHS LEFT JOIN school AS RHS ON (LHS.enrollment = RHS.enrollment)) ORDER BY school_name;

/*
Gold Result:
('Matthew Foster',)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Katherine Rodriguez',)
*/