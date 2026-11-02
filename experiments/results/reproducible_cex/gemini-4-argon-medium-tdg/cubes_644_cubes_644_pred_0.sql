-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY continent direction (ASC vs DESC) and NULL handling in Continent
INSERT INTO "country" ("Code", "Name", "Continent") VALUES ('ZAA', 'Anguilla', 'South America');
INSERT INTO "country" ("Code", "Name", "Continent") VALUES ('AAA', 'Anguilla', 'Asia');
INSERT INTO "country" ("Code", "Name", "Continent") VALUES ('MAA', 'Anguilla', 'Europe');
INSERT INTO "country" ("Code", "Name", "Continent") VALUES ('NAA', 'Anguilla', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "continent" FROM "country" WHERE ("name" = 'Anguilla') ORDER BY continent, country.code NULLS LAST;

/*
Gold Result:
(None,)
('Asia',)
('Europe',)
('South America',)
*/

-- Prediction Query
SELECT Continent FROM country WHERE Name = 'Anguilla';

/*
Prediction Result:
('South America',)
('Asia',)
('Europe',)
(None,)
*/