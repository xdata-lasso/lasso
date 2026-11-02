-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('article', 'Matthew Arroyo', 'brother', 'mention', 1098.5, 1951, 1099, 1100.5, 1101.5, 1102.5, 'Cabrera', 'soon', 'Maryland', 1103, 'education');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('nice', 'Linda Burns', 'sign', 'woman', 1104.5, 1951, 1100, 1106.5, 1107.5, 1108.5, 'Cox', 'theory', 'Ohio', 1104, 'space');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM country WHERE (indepyear > 1950.0) ORDER BY name, country.code NULLS LAST;

/*
Gold Result:
('Linda Burns',)
('Matthew Arroyo',)
*/

-- Prediction Query
SELECT Name FROM country WHERE IndepYear > 1950;

/*
Prediction Result:
('Matthew Arroyo',)
('Linda Burns',)
*/