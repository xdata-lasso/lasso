-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('ZMB', 'Zambia', 'Africa', 'Eastern Africa', 752618.0, 1964, 9169000, 37.2, 3377.0, 3922.0, 'Zambia_Local', 'Republic', 'Chiluba', NULL, 'ZM');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('KEN', 'Kenya', 'Africa', 'Eastern Africa', 580367.0, 1963, 30080000, 48.0, 9217.0, 10241.0, 'Kenya_Local', 'Republic', 'Moi', NULL, 'KE');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('DZA', 'Algeria', 'Africa', 'Northern Africa', 2381741.0, 1962, 31471000, 69.7, 49982.0, 46966.0, 'Al-Jazair', 'Republic', 'Bouteflika', NULL, 'DZ');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.0, -660, 126714000, 80.7, 3787042.0, 4192638.0, 'Nihon', 'Constitutional Monarchy', 'Akihito', NULL, 'JP');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('FRA', 'France', 'Europe', 'Western Europe', 551500.0, 843, 59225700, 78.8, 1424285.0, 1392448.0, 'France_Local', 'Republic', 'Chirac', NULL, 'FR');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('ASI', 'FakeAfricaInAsia', 'Asia', 'Africa', 1000.0, 2000, 50000, 70.0, 500.0, 450.0, 'FakeLocal', 'Republic', 'LeaderA', NULL, 'FA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('NUL', 'NullContinent', NULL, 'Africa', 1000.0, 2000, 50000, 70.0, 500.0, 450.0, 'NullLocal', 'Republic', 'LeaderN', NULL, 'NC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "gnpold", "name", MAX("population") AS "population" FROM (SELECT * FROM "country" WHERE ("continent" <> 'Asia' AND "continent" = 'Africa')) GROUP BY gnpold, name) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Algeria',)
('Kenya',)
('Zambia',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Africa' AND population < (SELECT MAX(population) FROM country WHERE Continent = 'Asia');

/*
Prediction Result:
('Zambia',)
('Kenya',)
('Algeria',)
*/