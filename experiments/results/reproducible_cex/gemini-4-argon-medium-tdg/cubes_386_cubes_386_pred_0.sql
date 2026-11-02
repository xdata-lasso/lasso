-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO continents (ContId, Continent) VALUES (5, 'Asia');
INSERT INTO continents (ContId, Continent) VALUES (15, 'Europe');
INSERT INTO continents (ContId, Continent) VALUES (25, 'Africa');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (10, 5, 'Japan');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (20, 15, 'France');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (30, 25, 'Egypt');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '10', 'Toyota', 'Toyota Motor Corp');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '10', 'Honda', 'Honda Motor Co');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '10', 'Nissan', 'Nissan Motor Co');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (4, '20', 'Renault', 'Groupe Renault');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT countryname FROM (SELECT * FROM (SELECT * FROM (SELECT id, maker, fullname, country, countryname, continent, countryid, COUNT(*) OVER () AS n FROM (SELECT id, maker, fullname, country, countryname, continent, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent FROM car_makers AS LHS INNER JOIN countries AS RHS ON (LHS.country = RHS.countryid)))) ORDER BY continent DESC) LIMIT 1);

/*
Gold Result:
('France',)
*/

-- Prediction Query
SELECT T2.CountryName FROM CAR_MAKERS AS T1 JOIN COUNTRIES AS T2 ON T1.Country = T2.CountryId GROUP BY T1.Country ORDER BY COUNT(*) DESC, T2.CountryName NULLS LAST LIMIT 1;

/*
Prediction Result:
('Japan',)
*/