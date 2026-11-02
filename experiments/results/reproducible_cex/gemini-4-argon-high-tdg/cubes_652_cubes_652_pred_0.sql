-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AAA', 'Zambia', 'Africa', 'Eastern Africa', 752618.0, 1951, 1000000, 50.5, 3000.0, 2800.0, 'ZambiaLocal', 'Republic', 'Leader A', 1, 'ZA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('BBB', 'Morocco', 'Africa', 'Northern Africa', 446550.0, 1956, 2000000, 65.0, 4000.0, 3500.0, 'Al-Maghrib', 'Monarchy', 'Leader B', 2, 'MA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('CCC', 'Algeria', 'Africa', 'Northern Africa', 2381741.0, 1962, 3000000, 70.0, 5000.0, 4500.0, 'Al-Jazair', 'Republic', 'Leader C', 3, 'DZ');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('DDD', 'India', 'Asia', 'Southern Asia', 3287263.0, 1950, 4000000, 62.0, 6000.0, 5500.0, 'Bharat', 'Republic', 'Leader D', 4, 'IN');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('EEE', 'Israel', 'Asia', 'Middle East', 21056.0, 1949, 500000, 78.0, 7000.0, 6500.0, 'Yisrael', 'Republic', 'Leader E', 5, 'IL');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('FFF', 'China', 'Asia', 'Eastern Asia', 9572900.0, -1523, 8000000, 71.0, 8000.0, 7500.0, 'Zhongquo', 'Republic', 'Leader F', 6, 'CN');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('GGG', 'Greenland', 'North America', 'North America', 2166090.0, NULL, 56000, 68.0, 1000.0, 900.0, 'Kalaallit Nunaat', 'Territory', 'Leader G', NULL, 'GL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM country WHERE (indepyear > 1950.0) ORDER BY name, country.code NULLS LAST;

/*
Gold Result:
('Algeria',)
('Morocco',)
('Zambia',)
*/

-- Prediction Query
SELECT Name FROM country WHERE IndepYear > 1950;

/*
Prediction Result:
('Zambia',)
('Morocco',)
('Algeria',)
*/