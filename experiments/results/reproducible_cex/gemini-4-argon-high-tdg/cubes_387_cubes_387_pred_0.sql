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
INSERT INTO continents (ContId, Continent) VALUES (100, 'America');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (100, 100, 'USA');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (100, '100', 'ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (100, 100, 'ford');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'ford', 'ford pinto');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'ford', 'ford maverick');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'ford', 'ford mustang');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'ford', 'ford torino');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'ford', 'ford galaxie');
INSERT INTO car_names (MakeId, Model, Make) VALUES (6, 'ford', 'ford ltd');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '20', 6, 200.0, '95', 3500, 15.0, 1978);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '25', 4, 140.0, '80', 2500, 16.5, 1972);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '24', 4, 140.0, '82', 2600, 16.0, 1972);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '14', 8, 351.0, '150', 4500, 13.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '18', 6, 250.0, '105', 3000, 15.5, 1970);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (6, '15', 8, 302.0, '140', 4000, 14.0, 1971);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM cars_data WHERE (weight <> 3000 AND weight <> 4000) ORDER BY YEAR;

/*
Gold Result:
(1972,)
(1975,)
(1978,)
*/

-- Prediction Query
SELECT DISTINCT year FROM cars_data WHERE weight BETWEEN 3000 AND 4000;

/*
Prediction Result:
(1978,)
(1970,)
(1971,)
*/