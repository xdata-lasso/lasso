-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO continents (ContId, Continent) VALUES (1, 'c');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'cn');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, 1, 'm', 'fm');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'a');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, NULL, 'x');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'a', 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model FROM (SELECT * FROM (SELECT * FROM (SELECT model, COUNT(*) AS n FROM car_names GROUP BY model) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Model FROM CAR_NAMES GROUP BY Model ORDER BY COUNT(*) DESC, Model NULLS LAST LIMIT 1;

/*
Prediction Result:
('a',)
*/