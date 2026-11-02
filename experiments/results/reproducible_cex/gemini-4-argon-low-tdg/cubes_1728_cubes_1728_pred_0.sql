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
-- Tests all truth combinations of County ('Los Angeles', 'San Francisco', other) and Location ('Northridge', 'San Francisco', other), including cross-combinations (e.g., County='San Francisco' and Location='Northridge').
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'CSUN', 'Northridge', 'Los Angeles', 1958);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'SFSU', 'San Francisco', 'San Francisco', 1899);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (3, 'Cross_LA_SF', 'San Francisco', 'Los Angeles', 1960);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (4, 'Cross_SF_NR', 'Northridge', 'San Francisco', 1965);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (5, 'CSULA', 'Los Angeles', 'Los Angeles', 1947);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (6, 'SF_OtherLoc', 'Daly City', 'San Francisco', 1970);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (7, 'OtherCounty_NR', 'Northridge', 'Ventura', 1980);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (8, 'OtherCounty_SF', 'San Francisco', 'San Mateo', 1985);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (9, 'SDSU', 'San Diego', 'San Diego', 1897);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM (SELECT * FROM "campuses" WHERE ("county" = 'Los Angeles' OR "county" = 'San Francisco')) WHERE ("location" = 'Northridge' OR "location" = 'San Francisco') ORDER BY campus, "campus" NULLS LAST;

/*
Gold Result:
('CSUN',)
('Cross_LA_SF',)
('Cross_SF_NR',)
('SFSU',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE LOCATION = 'Northridge' AND county = 'Los Angeles' UNION SELECT campus FROM campuses WHERE LOCATION = 'San Francisco' AND county = 'San Francisco';

/*
Prediction Result:
('CSUN',)
('SFSU',)
*/