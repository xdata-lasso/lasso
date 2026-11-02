-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO continents (ContId, Continent) VALUES (1, 'ContA');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'CountryA');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (2, 1, 'CountryB');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (3, 1, 'CountryC');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'M1', 'Maker1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'M2', 'Maker2');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '1', 'M3', 'Maker3');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (4, '1', 'M4', 'Maker4');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (5, '2', 'M5', 'Maker5');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (6, '2', 'M6', 'Maker6');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (7, '2', 'M7', 'Maker7');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (8, '3', 'M8', 'Maker8');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (9, '3', 'M9', 'Maker9');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (10, '03', 'M10', 'Maker10');
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
(3,)
*/