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
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (10, '1', 'amc', 'American Motor Company');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (20, '1', 'gm', 'General Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (30, '1', 'chevy', 'General Motors');
INSERT INTO car_makers (Id, Country, Maker, FullName) VALUES (40, '1', 'ford', 'Ford Motor Company');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (100, 20, 'chevrolet');
INSERT INTO model_list (ModelId, Maker, Model) VALUES (200, 40, 'ford');
INSERT INTO car_names (MakeId, Model, Make) VALUES (1000, 'chevrolet', 'chevrolet malibu');
INSERT INTO cars_data (Id, MPG, Cylinders, Edispl, Horsepower, Weight, Accelerate, Year) VALUES (1000, '18', 8, 307.0, '130', 3504, 12.0, 1970);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "LHS"."modelid" AS "modelid", "LHS"."maker" AS "maker", "LHS"."model" AS "model", "RHS"."fullname" AS "fullname", "RHS"."id" AS "id", "RHS"."n_distinct" AS "n_distinct" FROM "model_list" AS "LHS" CROSS JOIN (SELECT "fullname", "id", COUNT(DISTINCT "fullname") AS "n_distinct" FROM "car_makers" WHERE ("fullname" <> 'American Motor Company') GROUP BY fullname, id) AS RHS) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id = T2.Maker WHERE T1.FullName = 'American Motor Company';

/*
Prediction Result:
(0,)
*/