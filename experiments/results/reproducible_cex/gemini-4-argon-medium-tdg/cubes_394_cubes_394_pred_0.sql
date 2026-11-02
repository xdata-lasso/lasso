-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO continents (ContId, Continent) VALUES (1, 'Americas');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'Brazil');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (2, 1, 'Argentina');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (3, 1, 'Mexico');
-- Country 1 inserted first with 5 makers (tests ORDER BY count___ ASC vs insertion/CountryId order or DESC)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'B1', 'FB1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'B2', 'FB2');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '1', 'B3', 'FB3');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (4, '1', 'B4', 'FB4');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (5, '1', 'B5', 'FB5');
-- Country 2 inserted second with 3 makers
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (6, '2', 'A1', 'FA1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (7, '2', 'A2', 'FA2');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (8, '2', 'A3', 'FA3');
-- Country 3 inserted third with 3 makers (duplicate count 3: tests SELECT DISTINCT count___ vs SELECT count___)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (9, '3', 'M1', 'FM1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (10, '3', 'M2', 'FM2');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (11, '3', 'M3', 'FM3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT countryid, COUNT(*) AS n FROM (SELECT id, maker, fullname, country, countryname, continent, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent FROM car_makers AS LHS INNER JOIN countries AS RHS ON (LHS.country = RHS.countryid))) GROUP BY countryid) WHERE (n > 2) ORDER BY count___;

/*
Gold Result:
(3,)
(3,)
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM countries AS t1 JOIN car_makers AS t2 ON t1.countryid = t2.country GROUP BY t1.countryid HAVING COUNT(*) > 2;

/*
Prediction Result:
(5,)
(3,)
(3,)
*/