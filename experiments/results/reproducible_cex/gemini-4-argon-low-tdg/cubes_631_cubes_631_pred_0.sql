-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AAA', NULL, 'Asia', 'Eastern Asia', 100.0, 1990, 5000, 65.0, 500.0, 400.0, 'NullCountry', 'Republic', 'PersonA', 10, 'AA');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('ZZZ', 'Armenia', 'Asia', 'Middle East', 29800.0, 1991, 3520000, 66.4, 1813.0, 1627.0, 'Hajastan', 'Republic', 'Robert Kotšarjan', 126, 'AM');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BBB', 'Azerbaijan', 'Asia', 'Middle East', 86600.0, 1991, 7734000, 62.9, 4127.0, 4100.0, 'Azärbaycan', 'Federal Republic', 'Heydär Äliyev', 144, 'AZ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "country" WHERE ("continent" = 'Asia')) ORDER BY name) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Asia' ORDER BY LifeExpectancy, country.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Azerbaijan',)
*/