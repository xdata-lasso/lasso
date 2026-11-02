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
-- Tests basic GROUP BY, MAX vs MIN/AVG/SUM/COUNT, and inverse correlation between cylinders and max_accelerate_ for ORDER BY
INSERT INTO continents (ContId, Continent) VALUES (1, 'America');
INSERT INTO countries (CountryId, Continent, CountryName) VALUES (1, 1, 'USA');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'ford');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'ford', 'ford fiesta');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'ford', 'ford focus');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'ford', 'fordaurus');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'ford', 'ford explorer');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'ford', 'ford mustang');
INSERT INTO car_names (MakeId, Model, Make) VALUES (6, 'ford', 'ford gt');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '30', 4, 100.0, '70', 2000, 15.0, 1980);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '28', 4, 110.0, '75', 2100, 22.5, 1981);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '20', 6, 200.0, '110', 3000, 12.0, 1979);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '18', 6, 210.0, '120', 3100, 18.0, 1980);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '14', 8, 350.0, '180', 4000, 10.5, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (6, '12', 8, 400.0, '200', 4200, 14.0, 1976);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxaccelerate AS max_accelerate_, cylinders FROM (SELECT cylinders, MAX(accelerate) AS maxaccelerate FROM cars_data GROUP BY cylinders) ORDER BY max_accelerate_, cylinders NULLS LAST;

/*
Gold Result:
(14.0, 8)
(18.0, 6)
(22.5, 4)
*/

-- Prediction Query
SELECT MAX(Accelerate), Cylinders FROM CARS_DATA GROUP BY Cylinders;

/*
Prediction Result:
(22.5, 4)
(18.0, 6)
(14.0, 8)
*/