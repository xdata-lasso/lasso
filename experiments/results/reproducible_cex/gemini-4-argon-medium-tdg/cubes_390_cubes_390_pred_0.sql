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
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (1, '1', 'Ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'ford');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'ford', 'ford pinto');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'ford', 'ford maverick');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'ford', 'ford torino');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'ford', 'ford galaxie');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'ford', 'ford mustang');
INSERT INTO car_names (MakeId, Model, Make) VALUES (6, 'ford', 'ford fiesta');
INSERT INTO car_names (MakeId, Model, Make) VALUES (7, 'ford', 'ford escort');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '20', 4, 140.0, '90', 3000, 15.0, 1970);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '20', 4, 140.0, '90', 3000, 15.0, 1970);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '18', 6, 200.0, '110', 4000, 14.0, 1970);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '25', 4, 120.0, '80', 1001, 16.0, 1971);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '25', 4, 120.0, '80', 1002, 16.0, 1971);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (6, '22', 4, 130.0, '85', 2500, 15.5, 1972);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (7, '30', 4, 100.0, '70', 2500, 17.0, 1975);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, YEAR FROM (SELECT YEAR, AVG(weight) AS meanweight FROM cars_data GROUP BY YEAR) ORDER BY avg_weight_, YEAR NULLS LAST;

/*
Gold Result:
(1001.5, 1971)
(2500.0, 1972)
(2500.0, 1975)
(3333.3333333333335, 1970)
*/

-- Prediction Query
SELECT AVG(Weight), YEAR FROM CARS_DATA GROUP BY YEAR;

/*
Prediction Result:
(3333.3333333333335, 1970)
(1001.5, 1971)
(2500.0, 1972)
(2500.0, 1975)
*/