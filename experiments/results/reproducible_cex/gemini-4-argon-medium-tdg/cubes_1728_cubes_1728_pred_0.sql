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
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'CSU Northridge', 'Northridge', 'Los Angeles', 1958);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'San Francisco State', 'San Francisco', 'San Francisco', 1899);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (3, 'CSU Los Angeles', 'Los Angeles', 'Los Angeles', 1947);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (4, 'Fake Northridge', 'Northridge', 'Ventura', 2000);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (5, 'Fake SF', 'San Francisco', 'San Mateo', 2001);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (6, 'Cross Match 1', 'San Francisco', 'Los Angeles', 1980);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (7, 'Cross Match 2', 'Northridge', 'San Francisco', 1985);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM (SELECT * FROM "campuses" WHERE ("county" = 'Los Angeles' OR "county" = 'San Francisco')) WHERE ("location" = 'Northridge' OR "location" = 'San Francisco') ORDER BY campus, "campus" NULLS LAST;

/*
Gold Result:
('CSU Northridge',)
('Cross Match 1',)
('Cross Match 2',)
('San Francisco State',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE LOCATION = 'Northridge' AND county = 'Los Angeles' UNION SELECT campus FROM campuses WHERE LOCATION = 'San Francisco' AND county = 'San Francisco';

/*
Prediction Result:
('CSU Northridge',)
('San Francisco State',)
*/