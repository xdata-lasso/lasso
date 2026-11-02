-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO continents (ContId, Continent) VALUES (1, 'America');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'USA');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'Ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'f150');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'f150', 'ford f150');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '20', 6, 3.5, '250', 2500, 7.5, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM cars_data WHERE (weight <> 3000 AND weight <> 4000) ORDER BY YEAR;

/*
Gold Result:
(2020,)
*/

-- Prediction Query
SELECT DISTINCT year FROM cars_data WHERE weight BETWEEN 3000 AND 4000;

/*
Prediction Result:
*/