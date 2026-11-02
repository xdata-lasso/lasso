-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('YEM', 'Yemen', 'Asia', 'Middle East', 527968.0, 1918, 18112000, 59.8, 6041.0, 5729.0, 'Al-Yaman', 'Absolute Monarchy', 'Ali Abdullah Salih', 1, 'YE');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('OMN', 'Oman', 'Asia', 'Middle East', 309500.0, 1951, 2542000, 71.8, 16904.0, 16153.0, 'Uman', 'Constitutional Monarchy', 'Qabus ibn Said', 2, 'OM');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.0, -660, 126714000, 80.7, 3787042.0, 4192638.0, 'Nihon', 'Federation', 'Akihito', null, 'JP');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('BHR', 'Bahrain', 'Asia', 'Middle East', 694.0, 1971, 617000, 73.0, 6366.0, 6097.0, 'Al-Bahrayn', 'Republic', 'Hamad ibn Isa', null, 'BH');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('EGY', 'Egypt', 'Africa', 'Asia', 1001449.0, 1922, 68470000, 63.3, 82710.0, 75617.0, 'Asia', 'Republic', 'Hosni Mubarak', 3, 'EG');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('FRA', 'France', 'Europe', 'Western Europe', 551500.0, 843, 59225700, 78.8, 1424285.0, 1392448.0, 'France', 'Republic', 'Jacques Chirac', 4, 'FR');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'YEM', 'Sanaa', 'Sanaa', 503600);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (2, 'OMN', 'Muscat', 'Masqat', 51900);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (3, 'EGY', 'Asia', 'Cairo', 6789479);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (4, 'FRA', 'Paris', 'Ile-de-France', 2125246);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('YEM', 'Arabic', 'T', 99.6);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('OMN', 'Arabic', 'T', 76.7);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('EGY', 'Arabic', 'T', 98.8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "governmentform", "name", MIN("continent") AS "mincontinent" FROM (SELECT * FROM "country" WHERE ("continent" = 'Asia' AND "continent" <> 'Africa')) GROUP BY governmentform, name) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Bahrain',)
('Japan',)
('Oman',)
('Yemen',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Asia' AND population > (SELECT MIN(population) FROM country WHERE Continent = 'Africa');

/*
Prediction Result:
('Japan',)
*/