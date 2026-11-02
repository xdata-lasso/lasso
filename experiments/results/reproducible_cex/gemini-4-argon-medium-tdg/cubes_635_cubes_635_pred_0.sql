-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Population") VALUES ('NLD', 'Netherlands', 15864000);
INSERT INTO "country" ("Code", "Name", "Population") VALUES ('BEL', 'Belgium', 10239000);
INSERT INTO "country" ("Code", "Name", "Population") VALUES ('DEU', 'Germany', 82164700);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'NLD', 'Nijmegen', 'Gelderland', 150000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'NLD', 'Apeldoorn', 'Gelderland', 150000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'NLD', 'Arnhem', 'Gelderland', 200000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (4, 'BEL', 'FakeCity1', 'Gelderland', 120000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (5, 'BEL', 'FakeCity2', 'Gelderland', 80000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (6, 'NLD', 'Amsterdam', 'Noord-Holland', 731200);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (7, 'DEU', 'Gelderland', 'Nordrhein-Westfalen', 90000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (8, 'DEU', 'Kleve', 'gelderland', 50000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (9, 'DEU', 'Emmerich', 'New Gelderland', 30000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sumpopulation" AS "sum_population_" FROM (SELECT "countrycode", "district", SUM("population") AS "sumpopulation" FROM "city" GROUP BY "countrycode", "district") WHERE ("district" = 'Gelderland') ORDER BY sum_population_;

/*
Gold Result:
(200000,)
(500000,)
*/

-- Prediction Query
SELECT SUM(Population) FROM city WHERE District = 'Gelderland';

/*
Prediction Result:
(700000,)
*/