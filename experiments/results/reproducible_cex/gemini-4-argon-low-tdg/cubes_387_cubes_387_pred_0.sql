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
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, 1, 'Ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'Ford');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'Ford', 'Ford Fiesta');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'Ford', 'Ford Focus');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'Ford', 'Ford Mustang');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'Ford', 'Ford Explorer');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'Ford', 'Ford Taurus');
INSERT INTO car_names (MakeId, Model, Make) VALUES (6, 'Ford', 'Ford F-150');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '30', 4, 150.0, '100', 2999, 15.0, 1979);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '25', 4, 200.0, '110', 3000, 14.0, 1970);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '24', 6, 250.0, '120', 3001, 13.5, 1982);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '20', 6, 300.0, '150', 3999, 12.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '18', 8, 350.0, '160', 4000, 11.5, 1971);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (6, '15', 8, 400.0, '180', 4001, 10.0, 1973);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM cars_data WHERE (weight <> 3000 AND weight <> 4000) ORDER BY YEAR;

/*
Gold Result:
(1973,)
(1975,)
(1979,)
(1982,)
*/

-- Prediction Query
SELECT DISTINCT year FROM cars_data WHERE weight BETWEEN 3000 AND 4000;

/*
Prediction Result:
(1970,)
(1982,)
(1975,)
(1971,)
*/