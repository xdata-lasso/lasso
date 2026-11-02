-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO continents (ContId, Continent) VALUES (1, 'North America');
INSERT INTO continents (ContId, Continent) VALUES (2, 'Europe');
INSERT INTO continents (ContId, Continent) VALUES (3, 'Asia');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'USA');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (2, 2, 'Germany');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (3, 2, 'France');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (4, 3, 'Japan');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (5, 1, 'Canada');
-- Country 1: 4 makers (n > 2, included)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'Ford', 'Ford Motor Company');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'Ford', 'Ford Motor Company');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '1', NULL, 'General Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (4, '1', 'Tesla', NULL);
-- Country 2: 3 makers (n > 2, included)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (5, '2', 'BMW', 'Bayerische Motoren Werke');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (6, '2', 'Audi', 'Audi AG');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (7, '2', 'VW', 'Volkswagen');
-- Country 3: 2 makers (n = 2, boundary excluded)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (8, '3', 'Renault', 'Groupe Renault');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (9, '3', 'Peugeot', 'Peugeot S.A.');
-- Country 4: 1 maker (n = 1, excluded)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (10, '4', 'Toyota', 'Toyota Motor Corp');
-- Country NULL: 3 makers (excluded by INNER JOIN)
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (11, NULL, 'Unknown1', 'Unknown Maker 1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (12, NULL, 'Unknown2', 'Unknown Maker 2');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (13, NULL, 'Unknown3', 'Unknown Maker 3');
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