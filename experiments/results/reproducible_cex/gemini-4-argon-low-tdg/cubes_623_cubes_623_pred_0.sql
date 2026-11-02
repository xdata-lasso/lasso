-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C01', 'Country 1', 'Europe', 'Reg', 10.0, 2000, 100, 80.0, 10.0, 10.0, 'C1', 'Rep', 'H1', 1, 'C1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C02', 'Country 2', 'Europe', 'Reg', 10.0, 2000, 100, 80.0, 10.0, 10.0, 'C2', 'Rep', 'H2', 2, 'C2');
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C01', 'LangA', 'T', 50.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C01', 'LangB', 'F', 50.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C02', 'LangA', 'T', 100.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES (NULL, 'English', 'F', 10.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES (NULL, 'Spanish', 'F', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "countrycode" FROM (SELECT * FROM "countrylanguage" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "countrylanguage" WHERE ("language" = 'English')) AS RHS WHERE (LHS.countrycode = RHS.countrycode))) ORDER BY countrycode, "countrycode" NULLS LAST;

/*
Gold Result:
(None,)
('C01',)
('C02',)
*/

-- Prediction Query
SELECT CountryCode FROM countrylanguage EXCEPT SELECT CountryCode FROM countrylanguage WHERE LANGUAGE = 'English';

/*
Prediction Result:
('C01',)
('C02',)
*/