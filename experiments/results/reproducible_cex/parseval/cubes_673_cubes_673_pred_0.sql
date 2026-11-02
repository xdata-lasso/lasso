-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_4e4475', 'cou_e52997', 'Asia', 'cou_1386d3', 1.0, 1, 1, 1.0, 1.0, 1.0, 'cou_c4932f', 'cou_f29ed7', 'cou_e15605', 1, 'cou_0c4e55');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('cou_af1687', 'cou_ff43a0', 'Asia', 'cou_3ecd60', 1.0, 1, 1, 1.0, 1.0, 1.0, 'cou_2b4aad', 'cou_f5b6d2', 'cou_c35180', 1, 'cou_8478e4');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('G', 'cou_4b102e', 'Asia', 'cou_732d66', 0.03, -55602865, -59984348, 0.3, 0.03, 0.03, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -664303813, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_4', 'q_1_9a9449', 'cgsk9', 'cou_732d66', 0.04, 1610062532, -106629402, 0.4, 0.04, 0.04, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 1871297066, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_5', 'q_1_9a9449', 'u7vfe4hria2y', 'cou_732d66', 0.05, 1115440883, 1644814318, 0.5, 0.05, 0.05, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 1465859724, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('A', 'cou_4b102e', 'Asia', 'cou_732d66', 0.06, -1349201381, 1019800248, 0.6, 0.06, 0.06, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -1910425938, '03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "governmentform", "name", MIN("continent") AS "mincontinent" FROM (SELECT * FROM "country" WHERE ("continent" = 'Asia' AND "continent" <> 'Africa')) GROUP BY governmentform, name) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('cou_4b102e',)
('cou_e52997',)
('cou_ff43a0',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Asia' AND population > (SELECT MIN(population) FROM country WHERE Continent = 'Africa');

/*
Prediction Result:
*/