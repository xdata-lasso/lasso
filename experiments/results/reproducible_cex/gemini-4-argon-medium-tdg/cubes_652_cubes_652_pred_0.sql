-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for IndepYear (1949, 1950, 1951, NULL) and basic ASC ordering of Name.
INSERT INTO "country" ("Code", "Name", "IndepYear") VALUES ('C04', 'Zambia', 1964);
INSERT INTO "country" ("Code", "Name", "IndepYear") VALUES ('C01', 'Algeria', 1962);
INSERT INTO "country" ("Code", "Name", "IndepYear") VALUES ('C02', 'India', 1950);
INSERT INTO "country" ("Code", "Name", "IndepYear") VALUES ('C03', 'Libya', 1951);
INSERT INTO "country" ("Code", "Name", "IndepYear") VALUES ('C05', 'Israel', 1948);
INSERT INTO "country" ("Code", "Name", "IndepYear") VALUES ('C06', 'Antarctica', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM country WHERE (indepyear > 1950.0) ORDER BY name, country.code NULLS LAST;

/*
Gold Result:
('Algeria',)
('Libya',)
('Zambia',)
*/

-- Prediction Query
SELECT Name FROM country WHERE IndepYear > 1950;

/*
Prediction Result:
('Zambia',)
('Algeria',)
('Libya',)
*/