-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Code, Name, IndepYear) VALUES ('Z99', 'Zeta', 1960);
INSERT INTO country (Code, Name, IndepYear) VALUES ('A01', 'Alpha', 1975);
INSERT INTO country (Code, Name, IndepYear) VALUES ('D50', 'Duplicate', 1980);
INSERT INTO country (Code, Name, IndepYear) VALUES ('D10', 'Duplicate', 1990);
INSERT INTO country (Code, Name, IndepYear) VALUES ('M00', NULL, 1985);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM country WHERE (indepyear > 1950.0) ORDER BY name, country.code NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Duplicate',)
('Duplicate',)
('Zeta',)
*/

-- Prediction Query
SELECT Name FROM country WHERE IndepYear > 1950;

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Duplicate',)
('Duplicate',)
(None,)
*/