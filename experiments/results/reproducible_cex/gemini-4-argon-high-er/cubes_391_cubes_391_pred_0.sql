-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO continents (ContId, Continent) VALUES (1, 'Continent1');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'Country1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'Maker1', 'FullName1');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'Maker2', 'FullName2');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 2, 'ModelA');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (2, 1, 'ModelB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maker, model FROM model_list ORDER BY maker, model_list.modelid NULLS LAST;

/*
Gold Result:
(1, 'ModelB')
(2, 'ModelA')
*/

-- Prediction Query
SELECT Maker, Model FROM MODEL_LIST;

/*
Prediction Result:
(2, 'ModelA')
(1, 'ModelB')
*/