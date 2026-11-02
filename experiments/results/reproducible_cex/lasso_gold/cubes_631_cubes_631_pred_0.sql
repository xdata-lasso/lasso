-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('purpose', 'Daniel Doyle', 'Asia', 'rate', 1001.5, 1005, 1009, 1013.5, 1017.5, 1021.5, 'Robinson', 'sure', 'Michigan', 1025, 'source');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('brother', 'Stephanie Miller', 'Asia', 'science', 1012.5, 1018.0, 1024.0, 1030.5, 1036.5, 1042.5, 'Lawrence', 'collection', 'Louisiana', 1054.0, 'great');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('ago', 'Allen Robinson', 'Asia', 'offer', 1023.5, 1031.0, 1039.0, 1047.5, 1055.5, 1063.5, 'Pacheco', 'save', 'Georgia', 1083.0, 'blue');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('site', 'Alyssa Gonzalez', 'Asia', 'kind', 1034.5, 1044.0, 1054.0, 1064.5, 1074.5, 1084.5, 'Smith', 'knowledge', 'Indiana', 1112.0, 'best');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "country" WHERE ("continent" = 'Asia')) ORDER BY name) LIMIT 1);

/*
Gold Result:
('Allen Robinson',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Asia' ORDER BY LifeExpectancy, country.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Doyle',)
*/