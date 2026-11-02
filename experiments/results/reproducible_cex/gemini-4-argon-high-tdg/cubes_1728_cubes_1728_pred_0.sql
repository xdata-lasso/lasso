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
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Zeta Campus', 'San Francisco', 'Los Angeles', 1990);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Beta Campus', 'Northridge', 'San Francisco', 1985);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'Omega Campus', 'Northridge', 'Los Angeles', 1950);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (4, 'Alpha Campus', 'San Francisco', 'San Francisco', 2000);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (5, 'Gamma Campus', 'Pasadena', 'Los Angeles', 1960);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (6, 'Delta Campus', 'Northridge', 'Orange', 1970);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM (SELECT * FROM "campuses" WHERE ("county" = 'Los Angeles' OR "county" = 'San Francisco')) WHERE ("location" = 'Northridge' OR "location" = 'San Francisco') ORDER BY campus, "campus" NULLS LAST;

/*
Gold Result:
('Alpha Campus',)
('Beta Campus',)
('Omega Campus',)
('Zeta Campus',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE LOCATION = 'Northridge' AND county = 'Los Angeles' UNION SELECT campus FROM campuses WHERE LOCATION = 'San Francisco' AND county = 'San Francisco';

/*
Prediction Result:
('Alpha Campus',)
('Omega Campus',)
*/