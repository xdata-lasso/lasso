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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Zeta University', 'Malibu', 'Los Angeles', 1940);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Alpha State', 'Pomona', 'Los Angeles', 1990);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'Gamma Institute', 'Long Beach', 'Los Angeles', 1960);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'Beta College', 'Los Angeles', 'Orange', 1970);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Los Angeles', 'Irvine', 'Orange', 1980);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (2, 1990, 1500);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (3, 1960, 1200);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (4, 1970, 1300);
INSERT INTO degrees (Year, Campus, Degrees) VALUES (2000, 2, 500);
INSERT INTO degrees (Year, Campus, Degrees) VALUES (2001, 2, 550);
INSERT INTO degrees (Year, Campus, Degrees) VALUES (2000, 4, 400);
INSERT INTO discipline_enrollments (Campus, Discipline, Year, Undergraduate, Graduate) VALUES (2, 101, 2000, 1000, 200);
INSERT INTO discipline_enrollments (Campus, Discipline, Year, Undergraduate, Graduate) VALUES (2, 102, 2000, 800, 150);
INSERT INTO discipline_enrollments (Campus, Discipline, Year, Undergraduate, Graduate) VALUES (4, 101, 2000, 600, 100);
INSERT INTO enrollments (Campus, Year, TotalEnrollment_AY, FTE_AY) VALUES (2, 2000, 5000, 4500);
INSERT INTO enrollments (Campus, Year, TotalEnrollment_AY, FTE_AY) VALUES (2, 2001, 5200, 4700);
INSERT INTO enrollments (Campus, Year, TotalEnrollment_AY, FTE_AY) VALUES (4, 2000, 3000, 2800);
INSERT INTO faculty (Campus, Year, Faculty) VALUES (2, 2000, 250.5);
INSERT INTO faculty (Campus, Year, Faculty) VALUES (2, 2001, 260.0);
INSERT INTO faculty (Campus, Year, Faculty) VALUES (4, 2000, 180.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM "campuses" WHERE ("county" = 'Los Angeles') ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Alpha State',)
('Gamma Institute',)
('Zeta University',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE county = 'Los Angeles';

/*
Prediction Result:
('Zeta University',)
('Alpha State',)
('Gamma Institute',)
*/