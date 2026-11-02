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
INSERT INTO continents (ContId, Continent) VALUES (1, 'America');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'USA');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'amc', 'American Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'ford', 'Ford Motor Company');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (3, '1', 'unused', 'Unused Maker');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (10, '1', 'gm', 'General Motors');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 2, 'fiesta');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (2, 1, 'zeta');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (3, 1, 'alpha');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (4, 10, 'beta');
INSERT INTO car_names (MakeId, Model, Make) VALUES (101, 'zeta', 'AMC Zeta V1');
INSERT INTO car_names (MakeId, Model, Make) VALUES (102, 'zeta', 'AMC Zeta V2');
INSERT INTO car_names (MakeId, Model, Make) VALUES (103, 'alpha', 'AMC Alpha');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (101, '20', 6, 200.0, '100', 3000, 15.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (102, '22', 4, 140.0, '90', 2500, 16.5, 1978);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maker, model FROM model_list ORDER BY maker, model_list.modelid NULLS LAST;

/*
Gold Result:
(1, 'zeta')
(1, 'alpha')
(2, 'fiesta')
(10, 'beta')
*/

-- Prediction Query
SELECT Maker, Model FROM MODEL_LIST;

/*
Prediction Result:
(2, 'fiesta')
(1, 'zeta')
(1, 'alpha')
(10, 'beta')
*/