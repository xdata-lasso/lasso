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
-- Tests ORDER BY Campus ASC, DISTINCT vs ALL (duplicate Campus names), and NULL handling in Campus name.
-- Primary key Id is ordered inversely to Campus alphabetical order to catch missing ORDER BY or ORDER BY Id mutants.
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (10, 'Zeta University', 'Chico', 'Butte', 1950);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (20, 'Alpha College', 'Chico', 'Butte', 1960);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (30, 'Alpha College', 'Chico', 'Tehama', 1970);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (40, NULL, 'Chico', 'Glenn', 1980);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (5, 'Beta Institute', 'Chico', 'Butte', 1990);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM "campuses" WHERE ("location" = 'Chico') ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha College',)
('Alpha College',)
('Beta Institute',)
('Zeta University',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE LOCATION = 'Chico';

/*
Prediction Result:
('Beta Institute',)
('Zeta University',)
('Alpha College',)
('Alpha College',)
(None,)
*/