-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('DZA', 'Algeria', 'Africa', 'Northern Africa', 2381741.0, 1962, 31471000, 69.7, 49982.0, 46966.0, 'Al-Jaza’ir', 'Republic', 'Abdelaziz Bouteflika', 4, 'DZ');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AAA', 'Yemen', 'Asia', 'A_Region', 100.0, 1900, 1000, 50.0, 100.0, 90.0, 'A_Local', 'A_Gov', 'A_Head', 1, 'AA');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('MMM', 'Bahrain', 'Asia', 'M_Region', 500.0, 1950, 5000, 70.0, 500.0, 450.0, 'M_Local', 'M_Gov', 'M_Head', 2, 'MM');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('ZZZ', 'Vietnam', 'Asia', 'Z_Region', 900.0, 2000, 9000, 85.0, 900.0, 850.0, 'Z_Local', 'Z_Gov', 'Z_Head', 3, 'ZZ');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'AAA', 'AlphaCity', 'DistA', 500);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'MMM', 'ZetaCity', 'DistM', 2500);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'ZZZ', 'BetaCity', 'DistZ', 4500);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (4, 'DZA', 'Algiers', 'Alger', 2168000);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('AAA', 'Arabic', 'T', 99.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('MMM', 'English', 'F', 50.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('ZZZ', 'Vietnamese', 'T', 86.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('DZA', 'Berber', 'F', 14.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "country" WHERE ("continent" = 'Asia')) ORDER BY name) LIMIT 1);

/*
Gold Result:
('Bahrain',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Asia' ORDER BY LifeExpectancy, country.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Yemen',)
*/