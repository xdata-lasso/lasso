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
-- Tests basic GROUP BY Year, AVG(Weight) vs SUM/MIN/MAX/COUNT, DISTINCT Weight in AVG, and primary ORDER BY avg_weight_ ASC vs DESC.
INSERT INTO "continents" ("ContId", "Continent") VALUES (1, 'America');
INSERT INTO "countries" ("CountryId", "Continent", "CountryName") VALUES (1, 1, 'USA');
INSERT INTO "car_makers" ("Id", "Country", "Maker", "FullName") VALUES (1, '1', 'Ford', 'Ford Motor Company');
INSERT INTO "model_list" ("ModelId", "Maker", "Model") VALUES (1, 1, 'ford');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (1, 'ford', 'Ford A');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (2, 'ford', 'Ford B');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (3, 'ford', 'Ford C');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (4, 'ford', 'Ford D');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (5, 'ford', 'Ford E');
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (1, '20', 4, 100.0, '100', 2000, 15.0, 1970);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (2, '20', 4, 100.0, '100', 2000, 15.0, 1970);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (3, '20', 4, 100.0, '100', 5000, 15.0, 1970);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (4, '25', 6, 150.0, '120', 1000, 12.0, 1975);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (5, '25', 6, 150.0, '120', 2000, 12.0, 1975);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, YEAR FROM (SELECT YEAR, AVG(weight) AS meanweight FROM cars_data GROUP BY YEAR) ORDER BY avg_weight_, YEAR NULLS LAST;

/*
Gold Result:
(1500.0, 1975)
(3000.0, 1970)
*/

-- Prediction Query
SELECT AVG(Weight), YEAR FROM CARS_DATA GROUP BY YEAR;

/*
Prediction Result:
(3000.0, 1970)
(1500.0, 1975)
*/