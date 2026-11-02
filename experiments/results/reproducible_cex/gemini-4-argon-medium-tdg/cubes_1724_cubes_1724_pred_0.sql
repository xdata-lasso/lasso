-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, sorting by Campus, duplicate Campus names (SELECT vs SELECT DISTINCT), and NULL County handling.
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'CSU Los Angeles', 'Los Angeles', 'Los Angeles', 1947);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'CSU Northridge', 'Northridge', 'Los Angeles', 1958);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (3, 'CSU Dominguez Hills', 'Carson', 'Los Angeles', 1960);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (4, 'CSU Los Angeles', 'Downtown LA', 'Los Angeles', 1990);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (5, 'CSU Fullerton', 'Fullerton', 'Orange', 1957);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (6, 'CSU Unknown', 'Nowhere', NULL, 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM "campuses" WHERE ("county" = 'Los Angeles') ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('CSU Dominguez Hills',)
('CSU Los Angeles',)
('CSU Los Angeles',)
('CSU Northridge',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE county = 'Los Angeles';

/*
Prediction Result:
('CSU Los Angeles',)
('CSU Northridge',)
('CSU Dominguez Hills',)
('CSU Los Angeles',)
*/