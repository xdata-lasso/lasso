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
INSERT INTO continents (ContId, Continent) VALUES (1, 'america');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'usa');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'amc', 'American Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (2, '1', 'ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'amc');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (2, 2, 'ford');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (3, 1, 'amc hornet sportabout (sw)');
INSERT INTO car_names (MakeId, Model, Make) VALUES (10, 'amc', 'amc hornet sportabout (sw)');
INSERT INTO car_names (MakeId, Model, Make) VALUES (20, 'amc', 'amc hornet sportabout (sw)');
INSERT INTO car_names (MakeId, Model, Make) VALUES (30, 'amc', 'amc hornet sportabout (sw)');
INSERT INTO car_names (MakeId, Model, Make) VALUES (40, 'amc', 'amc hornet');
INSERT INTO car_names (MakeId, Model, Make) VALUES (50, 'amc hornet sportabout (sw)', 'amc gremlin');
INSERT INTO car_names (MakeId, Model, Make) VALUES (60, 'ford', 'ford pinto');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (10, '18', 6, 258.0, '110', 2962, 19.5, 1971);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (20, '19', 6, 232.0, '100', 2634, 9.8, 1972);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (30, '17', 6, 250.0, '105', 3100, 13.5, 1973);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (40, '21', 6, 199.0, '90', 2648, 15.0, 1970);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (50, '20', 6, 200.0, '95', 2700, 16.0, 1974);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (60, '25', 4, 98.0, '80', 2046, 19.0, 1971);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "accelerate" FROM (SELECT "LHS"."makeid" AS "makeid", "LHS"."model" AS "model", "LHS"."make" AS "make", "RHS"."mpg" AS "mpg", "RHS"."cylinders" AS "cylinders", "RHS"."edispl" AS "edispl", "RHS"."horsepower" AS "horsepower", "RHS"."weight" AS "weight", "RHS"."accelerate" AS "accelerate", "RHS"."year" AS "year" FROM (SELECT * FROM "car_names" WHERE ("make" = 'amc hornet sportabout (sw)')) AS LHS INNER JOIN cars_data AS RHS ON (LHS.makeid = RHS.id)) ORDER BY accelerate, "accelerate" NULLS LAST;

/*
Gold Result:
(9.8,)
(13.5,)
(19.5,)
*/

-- Prediction Query
SELECT T1.Accelerate FROM CARS_DATA AS T1 JOIN CAR_NAMES AS T2 ON T1.Id = T2.MakeId WHERE T2.Make = 'amc hornet sportabout (sw)';

/*
Prediction Result:
(19.5,)
(9.8,)
(13.5,)
*/