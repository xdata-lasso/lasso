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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'CSU Chico', 'Chico', 'Butte', 1887);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'CSU Fresno', 'Fresno', 'Fresno', 1911);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'CSU Fullerton', 'Fullerton', 'Orange', 1957);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'CSU Hayward', 'Hayward', 'Alameda', 1957);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Humboldt State', 'Arcata', 'Humboldt', 1913);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (1, 1996, 1000);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (2, 1996, 1000);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (3, 2000, 1996);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (4, 1996, 1996);
INSERT INTO csu_fees (Campus, Year, CampusFee) VALUES (5, 1995, 2500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(campusfee) OVER () AS avg_campusfee_ FROM csu_fees WHERE (YEAR = 1996 OR campusfee = 1996) ORDER BY avg_campusfee_;

/*
Gold Result:
(1498.0,)
*/

-- Prediction Query
SELECT AVG(campusfee) FROM csu_fees WHERE YEAR = 1996;

/*
Prediction Result:
(1332.0,)
*/