-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('purpose', 'Danielle Taylor', 'early', 'agreement', 0.0, 1001, 1004, 1007.5, 1010.5, 1013.5, 'Baldwin', 'list', 'Alabama', 1016, 'save');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('brother', 'Patrick Gardner', 'mouth', 'option', 0.0, 1014.0, 1019.0, 1024.5, 1029.5, 1034.5, 'Miles', 'perform', 'Wisconsin', 1045.0, 'knowledge');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('ago', 'Amanda Davis', 'play', 'decide', 0.0, 1027.0, 1034.0, 1041.5, 1048.5, 1055.5, 'Barnes', 'fall', 'Hawaii', 1074.0, 'grow');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", MIN("surfacearea") OVER () AS "minsurfacearea" FROM "country") WHERE ("continent" <> 'Europe' OR minsurfacearea < surfacearea) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Amanda Davis',)
('Danielle Taylor',)
('Patrick Gardner',)
*/

-- Prediction Query
SELECT Name FROM country WHERE SurfaceArea > (SELECT MIN(SurfaceArea) FROM country WHERE Continent = 'Europe');

/*
Prediction Result:
*/