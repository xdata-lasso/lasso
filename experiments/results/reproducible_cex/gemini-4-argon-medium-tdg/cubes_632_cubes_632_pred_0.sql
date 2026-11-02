-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name) VALUES ('USA', 'United States');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'USA', 'BelowMin', 'Dist', 159999);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (2, 'USA', 'ExactMin', 'Dist', 160000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (3, 'USA', 'JustAboveMin', 'Dist', 160001);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (4, 'USA', 'MidRange', 'Dist', 500000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (5, 'USA', 'JustBelowMax', 'Dist', 899999);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (6, 'USA', 'ExactMax', 'Dist', 900000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (7, 'USA', 'AboveMax', 'Dist', 900001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM city WHERE (population < 900000 AND population >= 160000) ORDER BY name, city.id NULLS LAST;

/*
Gold Result:
('ExactMin',)
('JustAboveMin',)
('JustBelowMax',)
('MidRange',)
*/

-- Prediction Query
SELECT name FROM city WHERE Population BETWEEN 160000 AND 900000;

/*
Prediction Result:
('ExactMin',)
('JustAboveMin',)
('MidRange',)
('JustBelowMax',)
('ExactMax',)
*/