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
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'USA');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'mustang');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'mustang', 'ford mustang 1');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'mustang', 'ford mustang 2');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'mustang', 'ford mustang 3');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'mustang', 'ford mustang 4');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'mustang', 'ford mustang 5');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '20', 4, 2.0, '100', 2500, 12.0, 1980);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '18', 4, 2.2, '110', 2600, 18.5, 1981);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '15', 8, 5.0, '200', 3800, 9.5, 1982);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '14', 8, 5.0, '210', 3900, 14.0, 1983);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '16', 6, 3.5, '150', 3100, 16.0, 1984);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxaccelerate AS max_accelerate_, cylinders FROM (SELECT cylinders, MAX(accelerate) AS maxaccelerate FROM cars_data GROUP BY cylinders) ORDER BY max_accelerate_, cylinders NULLS LAST;

/*
Gold Result:
(14.0, 8)
(16.0, 6)
(18.5, 4)
*/

-- Prediction Query
SELECT MAX(Accelerate), Cylinders FROM CARS_DATA GROUP BY Cylinders;

/*
Prediction Result:
(18.5, 4)
(16.0, 6)
(14.0, 8)
*/