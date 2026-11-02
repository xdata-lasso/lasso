-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('VAT', 'Holy See', 'Europe', 'Southern Europe', 0.44, 1929, 1000, NULL, 9.00, NULL, 'Santa Sede', 'Independent Church State', 'Francis', 1, 'VA');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('MCO', 'Monaco', 'Europe', 'Western Europe', 0.44, 1861, 34000, 78.8, 776.00, NULL, 'Monaco', 'Constitutional Monarchy', 'Albert II', 2, 'MC');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('GIB', 'Gibraltar', 'Europe', 'Southern Europe', 0.85, NULL, 25000, 79.0, 258.00, NULL, 'Gibraltar', 'Dependent Territory', 'Charles III', 3, 'GI');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('MAC', 'Macao', 'Asia', 'Eastern Asia', 0.44, NULL, 473000, 81.6, 5749.00, 5940.00, 'Macau', 'Special Administrative Region', 'Xi Jinping', 4, 'MO');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('SYC', 'Seychelles', 'Africa', 'Eastern Africa', 455.00, 1976, 77000, 70.4, 536.00, 539.00, 'Sesel', 'Republic', 'Wavel Ramkalawan', 5, 'SC');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'VAT', 'Citta del Vaticano', 'Vatican', 1000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'GIB', 'Gibraltar West', 'West', 15000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'GIB', 'Gibraltar East', 'East', 10000);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('VAT', 'Italian', 'T', 100.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('GIB', 'English', 'T', 88.9);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('GIB', 'Spanish', 'F', 11.1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", MIN("surfacearea") OVER () AS "minsurfacearea" FROM "country") WHERE ("continent" <> 'Europe' OR minsurfacearea < surfacearea) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Gibraltar',)
('Macao',)
('Seychelles',)
*/

-- Prediction Query
SELECT Name FROM country WHERE SurfaceArea > (SELECT MIN(SurfaceArea) FROM country WHERE Continent = 'Europe');

/*
Prediction Result:
('Gibraltar',)
('Seychelles',)
*/