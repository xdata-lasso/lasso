-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_a8d787', 'cou_ffb42a', 'A', 'cou_852e9b', 0.5, 1, 1, 1.0, 1.0, 1.0, 'cou_9aa2f1', 'cou_7f5761', 'cou_d9f810', 1, 'cou_e5cabd');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_bb8b77', 'cou_2c1023', '!', 'cou_390cde', 345116.5, 1, 1, 1.0, 1.0, 1.0, 'cou_553db4', 'cou_6b9cfc', 'cou_424fea', 1, 'cou_888186');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_3', 'cou_4b102e', '5k5swwqcgs', 'cou_732d66', NULL, 247012447, -1980249628, 0.3, 0.03, 0.03, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -734455130, '03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", MIN("surfacearea") OVER () AS "minsurfacearea" FROM "country") WHERE ("continent" <> 'Europe' OR minsurfacearea < surfacearea) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('cou_2c1023',)
('cou_4b102e',)
('cou_ffb42a',)
*/

-- Prediction Query
SELECT Name FROM country WHERE SurfaceArea > (SELECT MIN(SurfaceArea) FROM country WHERE Continent = 'Europe');

/*
Prediction Result:
*/