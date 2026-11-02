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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Campus A', 'Loc A', 'County A', 1950);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Campus B', 'Loc B', 'County B', 1960);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'Campus C', 'Loc C', 'County C', 1970);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'Campus D', 'Loc D', 'County D', 1980);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Campus E', 'Loc E', 'County E', 1990);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (6, 'Campus F', 'Loc F', 'County F', 1996);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (7, 'Campus G', 'Loc G', 'County G', 1996);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (1, 1996, 1000);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (2, 1996, 1000);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (3, 1996, 1996);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (4, 2000, 1996);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (5, 1996, 1501);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (6, 1995, 1500);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (7, 1997, 1997);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(campusfee) OVER () AS avg_campusfee_ FROM csu_fees WHERE (YEAR = 1996 OR campusfee = 1996) ORDER BY avg_campusfee_;

/*
Gold Result:
(1498.6,)
*/

-- Prediction Query
SELECT AVG(campusfee) FROM csu_fees WHERE YEAR = 1996;

/*
Prediction Result:
(1374.25,)
*/