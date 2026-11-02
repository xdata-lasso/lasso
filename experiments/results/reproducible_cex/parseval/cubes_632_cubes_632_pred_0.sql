-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_1', 'cou_4b102e', '5k5swwqcgs', 'cou_732d66', 0.01, 247012447, -1980249628, 0.1, 0.01, 0.01, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -734455130, '03');

-- Inserting into table: city --
INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (1, 'c_1', 'cit_5b8548', 'cit_90e850', 160000);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (3, 'c_1', 'cit_5b8548', 'cit_90e850', 160000);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (2, 'c_1', 'cit_c3ca4a', 'cit_90e850', 159999);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (4, 'c_1', 'cit_c3ca4a', 'cit_90e850', 900000);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (5, 'c_1', 'cit_c3ca4a', 'cit_90e850', NULL);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (6, 'c_1', 'cit_c3ca4a', 'cit_90e850', NULL);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (7, 'c_1', 'cit_c3ca4a', 'cit_90e850', NULL);

INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (8, 'c_1', 'cit_c3ca4a', 'cit_90e850', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM city WHERE (population < 900000 AND population >= 160000) ORDER BY name, city.id NULLS LAST;

/*
Gold Result:
('cit_5b8548',)
('cit_5b8548',)
*/

-- Prediction Query
SELECT name FROM city WHERE Population BETWEEN 160000 AND 900000;

/*
Prediction Result:
('cit_5b8548',)
('cit_5b8548',)
('cit_c3ca4a',)
*/