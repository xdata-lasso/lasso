-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (1013, 'hear', 'Northridge', 'Los Angeles', 1015);
INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (1014, 'determine', 'Northridge', 'San Francisco', 1026.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campus" FROM (SELECT * FROM "campuses" WHERE ("county" = 'Los Angeles' OR "county" = 'San Francisco')) WHERE ("location" = 'Northridge' OR "location" = 'San Francisco') ORDER BY campus, "campus" NULLS LAST;

/*
Gold Result:
('determine',)
('hear',)
*/

-- Prediction Query
SELECT campus FROM campuses WHERE LOCATION = 'Northridge' AND county = 'Los Angeles' UNION SELECT campus FROM campuses WHERE LOCATION = 'San Francisco' AND county = 'San Francisco';

/*
Prediction Result:
('hear',)
*/