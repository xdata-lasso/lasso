-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Campuses" ("id", "campus", "location", "county", "year") VALUES (11, '12', '12', '12', 12);
INSERT INTO "Campuses" ("id", "campus", "location", "county", "year") VALUES (12, '12', '12', '12', 12);
INSERT INTO "csu_fees" ("campus", "year", "campusfee") VALUES (12, 17, 1996);
INSERT INTO "csu_fees" ("campus", "year", "campusfee") VALUES (11, 1996, 1997);
INSERT INTO "degrees" ("year", "campus", "degrees") VALUES (12, 12, 12);
INSERT INTO "degrees" ("year", "campus", "degrees") VALUES (12, 11, 12);
INSERT INTO "discipline_enrollments" ("campus", "discipline", "year", "undergraduate", "graduate") VALUES (12, 14, 12, 12, 12);
INSERT INTO "discipline_enrollments" ("campus", "discipline", "year", "undergraduate", "graduate") VALUES (12, 13, 12, 12, 12);
INSERT INTO "enrollments" ("campus", "year", "totalenrollment_ay", "fte_ay") VALUES (12, 16, 12, 12);
INSERT INTO "enrollments" ("campus", "year", "totalenrollment_ay", "fte_ay") VALUES (12, 15, 12, 12);
INSERT INTO "faculty" ("campus", "year", "faculty") VALUES (12, 12, 12);
INSERT INTO "faculty" ("campus", "year", "faculty") VALUES (12, 12, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(campusfee) OVER () AS avg_campusfee_ FROM csu_fees WHERE (YEAR = 1996 OR campusfee = 1996) ORDER BY avg_campusfee_;

/*
Gold Result:
(1996.5,)
*/

-- Prediction Query
SELECT AVG(campusfee) FROM csu_fees WHERE YEAR = 1996;

/*
Prediction Result:
(1997.0,)
*/