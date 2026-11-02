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
-- Tests basic filtering, sorting order (ASC vs DESC, Campus vs Id), DISTINCT vs ALL, and inner join traps with empty child tables
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'Zeta University', 'Los Angeles', 'Los Angeles', 1950);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'Alpha College', 'Long Beach', 'Los Angeles', 1960);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (3, 'Alpha College', 'Pasadena', 'Los Angeles', 1970);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (4, 'Beta Institute', 'Irvine', 'Orange', 1980);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM "campuses" WHERE ("county" = 'Los Angeles') ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Alpha College',)
('Alpha College',)
('Zeta University',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE county = 'Los Angeles';

/*
Prediction Result:
('Zeta University',)
('Alpha College',)
('Alpha College',)
*/