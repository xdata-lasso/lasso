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
-- 1. cylinders > 6 and n != 6 (Cylinders = 8, n = 2) -> Included
-- 2. cylinders = 6 and n != 6 (Cylinders = 6, n = 2) -> Excluded (tests boundary > 6 vs >= 6)
-- 3. cylinders < 6 and n = 6 (Cylinders = 4, n = 6) -> Included (tests OR vs AND, and n = 6)
-- 4. cylinders > 6 and n = 6 (Cylinders = 10, n = 6) -> Included (tests duplicate output counts: two groups with count 6, checking DISTINCT vs ALL)
-- 5. cylinders = 7 and n = 1 (Cylinders = 7, n = 1) -> Included (tests exact boundary 7 for cylinders > 6, and ORDER BY count___ with counts 6, 2, 1)
-- 6. NULL cylinders with n = 6 -> Included (tests COUNT(*) vs COUNT(cylinders))
INSERT INTO "continents" ("ContId", "Continent") VALUES (1, 'America');
INSERT INTO "countries" ("CountryId", "Continent", "CountryName") VALUES (1, 1, 'USA');
INSERT INTO "car_makers" ("Id", "Country", "Maker", "FullName") VALUES (1, '1', 'Ford', 'Ford Motor Company');
INSERT INTO "model_list" ("ModelId", "Maker", "Model") VALUES (1, 1, 'f150');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (1, 'f150', 'Ford 1');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (2, 'f150', 'Ford 2');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (3, 'f150', 'Ford 3');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (4, 'f150', 'Ford 4');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (5, 'f150', 'Ford 5');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (6, 'f150', 'Ford 6');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (7, 'f150', 'Ford 7');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (8, 'f150', 'Ford 8');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (9, 'f150', 'Ford 9');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (10, 'f150', 'Ford 10');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (11, 'f150', 'Ford 11');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (12, 'f150', 'Ford 12');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (13, 'f150', 'Ford 13');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (14, 'f150', 'Ford 14');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (15, 'f150', 'Ford 15');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (16, 'f150', 'Ford 16');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (17, 'f150', 'Ford 17');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (18, 'f150', 'Ford 18');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (19, 'f150', 'Ford 19');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (20, 'f150', 'Ford 20');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (21, 'f150', 'Ford 21');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (22, 'f150', 'Ford 22');
INSERT INTO "car_names" ("MakeId", "Model", "Make") VALUES (23, 'f150', 'Ford 23');
-- Group 1: Cylinders = 4, n = 6 (Inserted first to test ordering when count=6 appears before count=1 and 2)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (1, '20', 4, 2.0, '100', 2500, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (2, '20', 4, 2.0, '100', 2500, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (3, '20', 4, 2.0, '100', 2500, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (4, '20', 4, 2.0, '100', 2500, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (5, '20', 4, 2.0, '100', 2500, 15.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (6, '20', 4, 2.0, '100', 2500, 15.0, 1980);
-- Group 2: Cylinders = 8, n = 2 (Included: cylinders > 6)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (7, '15', 8, 5.0, '200', 4000, 12.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (8, '15', 8, 5.0, '200', 4000, 12.0, 1980);
-- Group 3: Cylinders = 6, n = 2 (Excluded: cylinders = 6, n != 6)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (9, '18', 6, 3.5, '150', 3200, 14.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (10, '18', 6, 3.5, '150', 3200, 14.0, 1980);
-- Group 4: Cylinders = 7, n = 1 (Included: cylinders > 6)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (11, '16', 7, 4.0, '170', 3500, 13.0, 1980);
-- Group 5: Cylinders = 10, n = 6 (Included: cylinders > 6 AND n = 6)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (12, '10', 10, 6.0, '300', 4500, 10.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (13, '10', 10, 6.0, '300', 4500, 10.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (14, '10', 10, 6.0, '300', 4500, 10.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (15, '10', 10, 6.0, '300', 4500, 10.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (16, '10', 10, 6.0, '300', 4500, 10.0, 1980);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (17, '10', 10, 6.0, '300', 4500, 10.0, 1980);
-- Group 6: Cylinders = NULL, n = 6 (Included: COUNT(*) = 6, whereas COUNT(Cylinders) = 0)
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (18, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (19, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (20, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (21, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "cars_data" ("Id", "MPG", "Cylinders", "Edispl", "Horsepower", "Weight", "Accelerate", "Year") VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT cylinders, COUNT(*) AS n FROM cars_data GROUP BY cylinders) WHERE (cylinders > 6 OR n = 6) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(6,)
(6,)
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders > 6;

/*
Prediction Result:
(9,)
*/