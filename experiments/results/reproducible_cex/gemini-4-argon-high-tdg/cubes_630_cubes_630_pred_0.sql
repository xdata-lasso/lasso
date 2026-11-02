-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C01', 'Alpha', 'Europe', 'Central Africa', 100.0, 1960, 1000, 40.0, 500.0, 450.0, 'Alpha', 'Republic', 'Leader A', 1, 'C1');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C02', 'Beta', 'Europe', 'Central Africa', 200.0, 1962, 2000, 40.0, 600.0, 550.0, 'Beta', 'Republic', 'Leader B', 2, 'C2');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C03', 'Gamma', 'Europe', 'Central Africa', 300.0, 1965, 3000, 70.0, 700.0, 650.0, 'Gamma', 'Republic', 'Leader C', 3, 'C3');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C04', 'Delta', 'Asia', 'Central Africa', 50.0, 1970, 500, 80.0, 100.0, 90.0, 'Delta', 'Monarchy', 'Leader D', 4, 'C4');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C05', 'Epsilon', 'Asia', 'Central Africa', 60.0, 1975, 600, 90.0, 200.0, 180.0, 'Epsilon', 'Monarchy', 'Leader E', 5, 'C5');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C06', 'Zeta', 'Africa', 'Central Africa', 400.0, 1980, 4000, 60.0, 800.0, 750.0, 'Zeta', 'Republic', 'Leader F', 6, 'C6');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C07', 'Eta', 'Africa', 'Eastern Africa', 500.0, 1985, 5000, 30.0, 900.0, 850.0, 'Eta', 'Republic', 'Leader G', 7, 'C7');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('C08', 'Theta', 'Central Africa', 'Western Africa', 600.0, 1990, 6000, 20.0, 1000.0, 950.0, 'Theta', 'Republic', 'Leader H', 8, 'C8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanlifeexpectancy" AS "avg_lifeexpectancy_" FROM (SELECT "continent", AVG("lifeexpectancy") AS "meanlifeexpectancy" FROM (SELECT * FROM "country" WHERE ("region" = 'Central Africa')) GROUP BY continent) ORDER BY avg_lifeexpectancy_;

/*
Gold Result:
(50.0,)
(60.0,)
(85.0,)
*/

-- Prediction Query
SELECT AVG(LifeExpectancy) FROM country WHERE Region = 'Central Africa';

/*
Prediction Result:
(63.333333333333336,)
*/