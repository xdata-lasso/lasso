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
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (3, 3, 'Japan');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (4, 2, 'France');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'Ford', 'Ford Motor Company');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'GM', 'General Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '2', 'BMW', 'Bayerische Motoren Werke');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (4, NULL, 'Unknown', 'Unknown Maker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT countryname, country AS countryid FROM (SELECT id, maker, fullname, country, countryname, continent, n, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent, RHS.n AS n FROM car_makers AS LHS INNER JOIN (SELECT countryid, countryname, continent, COUNT(*) OVER () AS n FROM countries) AS RHS ON (LHS.country = RHS.countryid))) WHERE (n >= 1) ORDER BY countryname, countryid NULLS LAST;

/*
Gold Result:
('Germany', '2')
('USA', '1')
*/

-- Prediction Query
SELECT T1.CountryName, T1.CountryId FROM COUNTRIES AS T1 JOIN CAR_MAKERS AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryId HAVING COUNT(*) >= 1;

/*
Prediction Result:
('USA', 1)
('Germany', 2)
*/