-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Campuses" ("id", "campus", "location", "county", "year") VALUES (11, NULL, '16', '17', 1936);
INSERT INTO "Campuses" ("id", "campus", "location", "county", "year") VALUES (10, NULL, '18', '19', 1935);
INSERT INTO "csu_fees" ("campus", "year", "campusfee") VALUES (10, 10, 10);
INSERT INTO "degrees" ("year", "campus", "degrees") VALUES (10, 10, 10);
INSERT INTO "degrees" ("year", "campus", "degrees") VALUES (10, 11, 10);
INSERT INTO "discipline_enrollments" ("campus", "discipline", "year", "undergraduate", "graduate") VALUES (11, 13, 10, 10, 10);
INSERT INTO "discipline_enrollments" ("campus", "discipline", "year", "undergraduate", "graduate") VALUES (10, 12, 10, 10, 10);
INSERT INTO "enrollments" ("campus", "year", "totalenrollment_ay", "fte_ay") VALUES (10, 15, 10, 10);
INSERT INTO "enrollments" ("campus", "year", "totalenrollment_ay", "fte_ay") VALUES (10, 14, 10, 10);
INSERT INTO "faculty" ("campus", "year", "faculty") VALUES (10, 10, 10);
INSERT INTO "faculty" ("campus", "year", "faculty") VALUES (11, 10, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT campus FROM campuses WHERE (YEAR > 1935 AND YEAR < 1939) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE YEAR >= 1935 AND YEAR <= 1939;

/*
Prediction Result:
(None,)
(None,)
*/