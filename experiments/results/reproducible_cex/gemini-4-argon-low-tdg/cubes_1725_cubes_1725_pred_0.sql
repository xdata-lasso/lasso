-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result behavior when 'Los Angeles' is absent in County.
-- Crucially distinguishes grouped filtering (returns 0 rows) from ungrouped SELECT COUNT(*) WHERE County = 'Los Angeles' (returns 1 row with 0).
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'Los Angeles', 'Los Angeles', 'San Diego', 1950);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'CSUF', 'Fullerton', 'Orange', 1957);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (3, 'SJSU', 'San Jose', NULL, 1857);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "county", COUNT(*) AS "n" FROM "campuses" GROUP BY "county") WHERE ("county" = 'Los Angeles') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM campuses WHERE county = 'Los Angeles';

/*
Prediction Result:
(0,)
*/