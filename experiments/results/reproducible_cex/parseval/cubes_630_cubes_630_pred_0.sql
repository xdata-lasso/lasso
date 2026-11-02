-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_29d5c5', 'cou_12d0b6', 'cou_593344', 'Central Africa', 1.0, 1, 1, 1.0, 1.0, 1.0, 'cou_0575fb', 'cou_aa5957', 'cou_4b3734', 1, 'cou_e87a8a');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_345806', 'cou_fcf032', 'cou_78229b', 'Central Africa', 1.0, 1, 1, 1.0, 1.0, 1.0, 'cou_3444a9', 'cou_ae599b', 'cou_07fa09', 1, 'cou_ad5645');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanlifeexpectancy" AS "avg_lifeexpectancy_" FROM (SELECT "continent", AVG("lifeexpectancy") AS "meanlifeexpectancy" FROM (SELECT * FROM "country" WHERE ("region" = 'Central Africa')) GROUP BY continent) ORDER BY avg_lifeexpectancy_;

/*
Gold Result:
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT AVG(LifeExpectancy) FROM country WHERE Region = 'Central Africa';

/*
Prediction Result:
(1.0,)
*/