-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_6d393d', 'cou_cce62b', 'Africa', 'cou_f332f1', 1.0, 1, 1, 1.0, 1.0, 1.0, 'cou_bbf001', 'cou_a772e3', 'cou_5b6c42', 1, 'cou_029a85');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_df52d8', 'cou_6b694a', 'Africa', 'cou_4d5b01', 1.0, 1, 1, 1.0, 1.0, 1.0, 'cou_4643f9', 'cou_b71650', 'cou_8e2877', 1, 'cou_91b8ac');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('?', 'cou_4b102e', 'Africa', 'cou_732d66', 0.03, -55602865, -59984348, 0.3, 0.03, 0.03, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -664303813, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('A', 'cou_4b102e', 'Africa', 'cou_732d66', 0.04, -1022641847, -1726781632, 0.4, 0.04, 0.04, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 247012447, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_5', 'q_1_1d20b7', '8c4pgu7vfe', 'cou_732d66', 0.05, -1633151678, -252690330, 0.5, 0.05, 0.05, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 1115440883, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_6', 'q_1_1d20b7', 'hsrwbbp', 'cou_732d66', 0.06, 13244799, -1659388584, 0.6, 0.06, 0.06, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 1526238907, '03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "gnpold", "name", MAX("population") AS "population" FROM (SELECT * FROM "country" WHERE ("continent" <> 'Asia' AND "continent" = 'Africa')) GROUP BY gnpold, name) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('cou_4b102e',)
('cou_4b102e',)
('cou_6b694a',)
('cou_cce62b',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Africa' AND population < (SELECT MAX(population) FROM country WHERE Continent = 'Asia');

/*
Prediction Result:
*/