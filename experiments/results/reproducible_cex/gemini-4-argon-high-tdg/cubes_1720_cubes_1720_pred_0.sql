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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Stanislaus', 'Turlock', 'Stanislaus', 1958);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Fullerton', 'Fullerton', 'Orange', 1958);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'San Jose', 'San Jose', 'Santa Clara', 1957);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'Sonoma', 'Rohnert Park', 'Sonoma', 1959);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Hayward', 'Hayward', 'Alameda', 1958);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (6, 'Fullerton', 'Irvine', 'Orange', 1958);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT campus FROM campuses WHERE (YEAR = 1958) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Fullerton',)
('Fullerton',)
('Hayward',)
('Stanislaus',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE YEAR = 1958;

/*
Prediction Result:
('Stanislaus',)
('Fullerton',)
('Hayward',)
('Fullerton',)
*/