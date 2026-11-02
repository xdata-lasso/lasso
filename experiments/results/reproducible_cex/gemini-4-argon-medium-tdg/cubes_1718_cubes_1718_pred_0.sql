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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Campus_1934', 'Loc1', 'County1', 1934);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Campus_1935', 'Loc2', 'County2', 1935);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'Campus_1936', 'Loc3', 'County3', 1936);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'Campus_1937', 'Loc4', 'County4', 1937);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Campus_1938', 'Loc5', 'County5', 1938);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (6, 'Campus_1939', 'Loc6', 'County6', 1939);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (7, 'Campus_1940', 'Loc7', 'County7', 1940);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT campus FROM campuses WHERE (YEAR > 1935 AND YEAR < 1939) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Campus_1936',)
('Campus_1937',)
('Campus_1938',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE YEAR >= 1935 AND YEAR <= 1939;

/*
Prediction Result:
('Campus_1935',)
('Campus_1936',)
('Campus_1937',)
('Campus_1938',)
('Campus_1939',)
*/