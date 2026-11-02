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
INSERT INTO model_list (ModelId, Maker, Model) VALUES (1, 1, 'ford');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1, 'ford', 'ford pinto');
INSERT INTO car_names (MakeId, Model, Make) VALUES (2, 'ford', 'ford fiesta');
INSERT INTO car_names (MakeId, Model, Make) VALUES (3, 'ford', 'ford escort');
INSERT INTO car_names (MakeId, Model, Make) VALUES (4, 'ford', 'ford mustang');
INSERT INTO car_names (MakeId, Model, Make) VALUES (5, 'ford', 'ford ranger');
INSERT INTO car_names (MakeId, Model, Make) VALUES (6, 'ford', 'ford focus');
INSERT INTO car_names (MakeId, Model, Make) VALUES (7, 'ford', 'ford maverick');
INSERT INTO car_names (MakeId, Model, Make) VALUES (8, 'ford', 'ford granada');
INSERT INTO car_names (MakeId, Model, Make) VALUES (9, 'ford', 'ford proto');
INSERT INTO car_names (MakeId, Model, Make) VALUES (10, 'ford', 'ford torino');
INSERT INTO car_names (MakeId, Model, Make) VALUES (11, 'ford', 'ford galaxie');
INSERT INTO car_names (MakeId, Model, Make) VALUES (12, 'ford', 'ford ltd');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1, '25', 4, 140.0, '90', 2200, 15.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (2, '26', 4, 141.0, '91', 2210, 15.5, 1976);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (3, '27', 4, 142.0, '92', 2220, 16.0, 1977);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (4, '28', 4, 143.0, '93', 2230, 16.5, 1978);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (5, '29', 4, 144.0, '94', 2240, 17.0, 1979);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (6, '30', 4, 145.0, '95', 2250, 17.5, 1980);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (7, '20', 6, 200.0, '110', 3000, 14.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (8, '21', 6, 201.0, '112', 3050, 14.2, 1976);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (9, '18', 7, 250.0, '130', 3500, 13.0, 1977);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (10, '14', 8, 302.0, '150', 4000, 12.0, 1975);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (11, '15', 8, 351.0, '160', 4100, 11.5, 1976);
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (12, '16', 8, 400.0, '170', 4200, 11.0, 1977);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT cylinders, COUNT(*) AS n FROM cars_data GROUP BY cylinders) WHERE (cylinders > 6 OR n = 6) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders > 6;

/*
Prediction Result:
(4,)
*/