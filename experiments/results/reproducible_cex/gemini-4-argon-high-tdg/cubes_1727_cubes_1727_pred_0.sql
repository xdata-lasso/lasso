-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (1, 'Northridge', 'Beta', 'Los Angeles', 1970);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (2, 'Channel Islands', 'Gamma', 'Los Angeles', 1960);
INSERT INTO Campuses (Id, Campus, Location, County, Year) VALUES (3, 'Dominguez Hills', 'Alpha', 'Los Angeles', 1990);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM "campuses" WHERE ("county" = 'Los Angeles' AND YEAR > 1950) ORDER BY campus, campuses.id NULLS LAST;

/*
Gold Result:
('Channel Islands',)
('Dominguez Hills',)
('Northridge',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE county = 'Los Angeles' AND YEAR > 1950;

/*
Prediction Result:
('Northridge',)
('Channel Islands',)
('Dominguez Hills',)
*/