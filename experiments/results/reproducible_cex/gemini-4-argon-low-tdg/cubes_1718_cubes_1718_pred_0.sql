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
-- Tests exact boundary conditions (1934, 1935, 1936, 1937, 1938, 1939, 1940), NULL Year, and basic ordering vs insertion order.
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Zeta University', 'Loc1', 'County1', 1936);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Alpha College', 'Loc2', 'County2', 1938);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'Beta Institute', 'Loc3', 'County3', 1937);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'Boundary Low', 'Loc4', 'County4', 1935);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Boundary High', 'Loc5', 'County5', 1939);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (6, 'Out Low', 'Loc6', 'County6', 1934);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (7, 'Out High', 'Loc7', 'County7', 1940);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (8, 'Null Year Campus', 'Loc8', 'County8', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT campus FROM campuses WHERE (YEAR > 1935 AND YEAR < 1939) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Alpha College',)
('Beta Institute',)
('Zeta University',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE YEAR >= 1935 AND YEAR <= 1939;

/*
Prediction Result:
('Zeta University',)
('Alpha College',)
('Beta Institute',)
('Boundary Low',)
('Boundary High',)
*/