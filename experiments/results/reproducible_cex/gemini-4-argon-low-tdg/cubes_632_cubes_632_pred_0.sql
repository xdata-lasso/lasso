-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name) VALUES ('USA', 'United States');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'USA', 'City_159999', 'D1', 159999);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (2, 'USA', 'City_160000', 'D1', 160000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (3, 'USA', 'City_160001', 'D1', 160001);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (4, 'USA', 'City_899999', 'D1', 899999);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (5, 'USA', 'City_900000', 'D1', 900000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (6, 'USA', 'City_900001', 'D1', 900001);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (7, 'USA', 'City_NullPop', 'D1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM city WHERE (population < 900000 AND population >= 160000) ORDER BY name, city.id NULLS LAST;

/*
Gold Result:
('City_160000',)
('City_160001',)
('City_899999',)
*/

-- Prediction Query
SELECT name FROM city WHERE Population BETWEEN 160000 AND 900000;

/*
Prediction Result:
('City_160000',)
('City_160001',)
('City_899999',)
('City_900000',)
*/