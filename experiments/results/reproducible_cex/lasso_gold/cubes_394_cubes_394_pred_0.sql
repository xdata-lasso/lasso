-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1230, 'family');
INSERT INTO "continents" ("contid", "continent") VALUES (1231, 'maintain');
INSERT INTO "continents" ("contid", "continent") VALUES (1232, 'enjoy');
INSERT INTO "continents" ("contid", "continent") VALUES (1248, 'weight');
INSERT INTO "continents" ("contid", "continent") VALUES (1249, 'artist');
INSERT INTO "continents" ("contid", "continent") VALUES (1250, 'community');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1233, 1230, 'Tunisia');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1234, 1230, 'Uzbekistan');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1235, 1230, 'Belarus');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1251, 1248, 'Hong Kong');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1252, 1248, 'Afghanistan');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1253, 1248, 'Iceland');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1236, 1233, 'level', 'Chase');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1237, 1233, 'system', 'Garcia');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1238, 1233, 'training', 'Pearson');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1245, 1233, 'time', 'Russell');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1254, 1251, 'evidence', 'Glover');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1255, 1251, 'with', 'Mitchell');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1256, 1251, 'step', 'Horton');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT countryid, COUNT(*) AS n FROM (SELECT id, maker, fullname, country, countryname, continent, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent FROM car_makers AS LHS INNER JOIN countries AS RHS ON (LHS.country = RHS.countryid))) GROUP BY countryid) WHERE (n > 2) ORDER BY count___;

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM countries AS t1 JOIN car_makers AS t2 ON t1.countryid = t2.country GROUP BY t1.countryid HAVING COUNT(*) > 2;

/*
Prediction Result:
(4,)
(3,)
*/