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
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'ford_model_a');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (2, 1, 'unused_model');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'ford_model_a', 'ford a1');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'ford_model_a', 'ford a2');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'ford_model_a', 'ford a3');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'ford_model_a', 'ford a4');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'ford_model_a', 'ford a5');
INSERT INTO car_names (MakeId, Model, Make) VALUES (6, 'ford_model_a', 'ford a6');
INSERT INTO car_names (MakeId, Model, Make) VALUES (7, 'ford_model_a', 'ford a7');
INSERT INTO car_names (MakeId, Model, Make) VALUES (8, 'ford_model_a', 'ford a8');
INSERT INTO car_names (MakeId, Model, Make) VALUES (9, 'unused_model', 'ford unused');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '25', 4, 140.0, '90', 2200, 15.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '28', 4, 120.0, '75', 2100, 19.5, 1976);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '30', 4, 110.0, '70', 2000, 17.2, 1977);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '20', 6, 200.0, '110', 3000, 12.5, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '18', 6, 225.0, '105', 3200, 14.0, 1978);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (6, '14', 8, 350.0, '165', 4200, 10.0, 1973);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (7, '13', 8, 400.0, '175', 4500, 11.5, 1974);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (8, '10', 12, 450.0, '220', 4800, 9.5, 1972);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxaccelerate AS max_accelerate_, cylinders FROM (SELECT cylinders, MAX(accelerate) AS maxaccelerate FROM cars_data GROUP BY cylinders) ORDER BY max_accelerate_, cylinders NULLS LAST;

/*
Gold Result:
(9.5, 12)
(11.5, 8)
(14.0, 6)
(19.5, 4)
*/

-- Prediction Query
SELECT MAX(Accelerate), Cylinders FROM CARS_DATA GROUP BY Cylinders;

/*
Prediction Result:
(19.5, 4)
(14.0, 6)
(11.5, 8)
(9.5, 12)
*/