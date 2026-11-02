-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('show', 'Calvin Nielsen', 'bar', 'old', 1030.5, 1031, 1032, 1033.5, 1034.5, 1035.5, 'Carter', 'production', 'South Carolina', 1036, 'value');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('answer', 'Patricia Galloway', 'top', 'early', 1039.5, 1040, 1041, 1042.5, 1043.5, 1044.5, 'Delacruz', 'husband', 'Louisiana', 1045, 'long');
INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (1037, 'show', 'Laura Bush', 'Gelderland', 1038);
INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (1046, 'answer', 'Holly Wood', 'Gelderland', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sumpopulation" AS "sum_population_" FROM (SELECT "countrycode", "district", SUM("population") AS "sumpopulation" FROM "city" GROUP BY "countrycode", "district") WHERE ("district" = 'Gelderland') ORDER BY sum_population_;

/*
Gold Result:
(None,)
(1038,)
*/

-- Prediction Query
SELECT SUM(Population) FROM city WHERE District = 'Gelderland';

/*
Prediction Result:
(1038,)
*/