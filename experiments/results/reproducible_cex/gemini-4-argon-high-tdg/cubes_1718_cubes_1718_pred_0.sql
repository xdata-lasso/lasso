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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (10, 'San Diego State', 'San Diego', 'San Diego', 1935);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (20, 'Fresno State', 'Fresno', 'Fresno', 1939);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (30, 'Zeta Campus', 'Alpha Loc', 'Beta County', 1937);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (40, 'Alpha Campus', 'Zeta Loc', 'Gamma County', 1938);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (50, 'Beta Campus', 'Mid Loc', 'Alpha County', 1936);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (60, 'Gamma Campus', 'Delta Loc', 'Delta County', 1934);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (70, 'Delta Campus', 'Epsilon Loc', 'Epsilon County', 1940);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT campus FROM campuses WHERE (YEAR > 1935 AND YEAR < 1939) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Alpha Campus',)
('Beta Campus',)
('Zeta Campus',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE YEAR >= 1935 AND YEAR <= 1939;

/*
Prediction Result:
('San Diego State',)
('Fresno State',)
('Zeta Campus',)
('Alpha Campus',)
('Beta Campus',)
*/