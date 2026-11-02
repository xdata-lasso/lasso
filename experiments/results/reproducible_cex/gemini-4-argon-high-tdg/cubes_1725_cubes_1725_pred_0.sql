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
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (201, 'Los Angeles', 'Los Angeles', 'Ventura', 1960);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (202, 'East Campus', 'Pasadena', 'los angeles', 1961);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (203, 'West Campus', 'Santa Monica', 'LOS ANGELES', 1962);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (204, 'South Campus', 'Compton', 'Los Angeles County', 1963);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (205, 'North Campus', 'Valencia', NULL, 1964);
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