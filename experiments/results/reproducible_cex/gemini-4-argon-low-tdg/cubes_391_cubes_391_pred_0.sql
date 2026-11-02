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
-- Tests basic ordering by Maker, tie-breaking by ModelId (where ModelId order opposes alphabetical Model order), and unmatched car_makers (to kill erroneous INNER/RIGHT JOINs).
INSERT INTO continents (ContId, Continent) VALUES (1, 'North America');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'USA');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'ford', 'Ford Motor Company');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'gm', 'General Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '1', 'chrysler', 'Chrysler');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (10, 2, 'camaro');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (20, 1, 'mustang');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (30, 1, 'Bronco');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maker, model FROM model_list ORDER BY maker, model_list.modelid NULLS LAST;

/*
Gold Result:
(1, 'mustang')
(1, 'Bronco')
(2, 'camaro')
*/

-- Prediction Query
SELECT Maker, Model FROM MODEL_LIST;

/*
Prediction Result:
(2, 'camaro')
(1, 'mustang')
(1, 'Bronco')
*/