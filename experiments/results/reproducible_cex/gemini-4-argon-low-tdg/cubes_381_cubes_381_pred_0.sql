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
-- Tests:
-- 1. Boundary conditions for `cylinders > 6` (Testing cylinders = 6, 7, 8).
-- 2. Boundary conditions for `n = 6` (Testing n = 1, 5, 6, 7).
-- 3. Logical operator `OR` vs `AND` (Groups satisfying only left, only right, or neither).
-- 4. Duplicate counts across different cylinder groups (cylinders = 7 and cylinders = 8 both have n = 1) to kill `SELECT DISTINCT` mutants.
-- 5. Ordering of results (`ORDER BY count___` ASC vs DESC vs `ORDER BY cylinders`).
INSERT INTO "continents" ("ContId", "Continent") VALUES (1, 'America');
INSERT INTO "countries" ("CountryId", "Continent", "CountryName") VALUES (1, 1, 'USA');
INSERT INTO "car_makers" ("Id", "Country", "Maker", "FullName") VALUES (1, '1', 'ford', 'Ford Motor Company');
INSERT INTO "model_list" ("ModelId", "Maker", "Model") VALUES (1, 1, 'ford');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (1, 'ford', 'car1');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (2, 'ford', 'car2');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (3, 'ford', 'car3');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (4, 'ford', 'car4');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (5, 'ford', 'car5');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (6, 'ford', 'car6');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (7, 'ford', 'car7');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (8, 'ford', 'car8');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (9, 'ford', 'car9');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (10, 'ford', 'car10');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (11, 'ford', 'car11');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (12, 'ford', 'car12');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (13, 'ford', 'car13');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (14, 'ford', 'car14');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (15, 'ford', 'car15');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (16, 'ford', 'car16');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (17, 'ford', 'car17');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (18, 'ford', 'car18');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (19, 'ford', 'car19');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (20, 'ford', 'car20');
-- Group: cylinders = 4, n = 6 (Satisfies n = 6, fails cylinders > 6)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (1, '20', 4, 100.0, '80', 2000, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (2, '20', 4, 100.0, '80', 2000, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (3, '20', 4, 100.0, '80', 2000, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (4, '20', 4, 100.0, '80', 2000, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (5, '20', 4, 100.0, '80', 2000, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (6, '20', 4, 100.0, '80', 2000, 15.0, 1980);
-- Group: cylinders = 6, n = 5 (Fails cylinders > 6 boundary, fails n = 6 boundary)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (7, '20', 6, 150.0, '100', 2500, 14.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (8, '20', 6, 150.0, '100', 2500, 14.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (9, '20', 6, 150.0, '100', 2500, 14.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (10, '20', 6, 150.0, '100', 2500, 14.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (11, '20', 6, 150.0, '100', 2500, 14.0, 1980);
-- Group: cylinders = 5, n = 7 (Fails cylinders > 6, fails n = 6 upper boundary)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (12, '20', 5, 120.0, '90', 2200, 14.5, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (13, '20', 5, 120.0, '90', 2200, 14.5, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (14, '20', 5, 120.0, '90', 2200, 14.5, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (15, '20', 5, 120.0, '90', 2200, 14.5, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (16, '20', 5, 120.0, '90', 2200, 14.5, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (17, '20', 5, 120.0, '90', 2200, 14.5, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (18, '20', 5, 120.0, '90', 2200, 14.5, 1980);
-- Group: cylinders = 7, n = 1 (Satisfies cylinders > 6 boundary, fails n = 6)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (19, '15', 7, 200.0, '130', 3000, 12.0, 1980);
-- Group: cylinders = 8, n = 1 (Satisfies cylinders > 6, produces duplicate n=1 in output)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (20, '12', 8, 300.0, '160', 3500, 11.0, 1980);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT cylinders, COUNT(*) AS n FROM cars_data GROUP BY cylinders) WHERE (cylinders > 6 OR n = 6) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders > 6;

/*
Prediction Result:
(2,)
*/