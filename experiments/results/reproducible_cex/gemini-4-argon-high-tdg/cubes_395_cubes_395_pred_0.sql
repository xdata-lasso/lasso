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
INSERT INTO continents (ContId, Continent) VALUES (1, 'Europe');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'Germany');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'vw', 'Volkswagen');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'vw');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'vw', 'vw rabbit');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'vw', 'vw dasher');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'vw', 'vw jetta');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'vw', 'vw scirocco');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '29', 4, 97.0, '75', 2171, 16.0, 1979);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '31', 4, 89.0, '71', 1925, 14.0, 1979);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '33', 4, 105.0, '74', 2190, 14.2, 1981);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '26', 4, 97.0, '78', 2200, 14.5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM cars_data GROUP BY YEAR) WHERE (YEAR = 1980 AND n <= 1980) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE YEAR = 1980;

/*
Prediction Result:
(0,)
*/