-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (15, '35');
INSERT INTO "continents" ("contid", "continent") VALUES (14, '35');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (17, 14, '35');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (16, 14, '35');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (19, NULL, '35', '35');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (18, 16, '35', '35');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (21, 18, '13');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (20, 19, '12');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (23, NULL, '35');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (22, NULL, '35');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (23, '24', 25, 26, '27', 3000, 28, 34);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (22, '29', 30, 31, '32', 3001, 33, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM cars_data WHERE (weight <> 3000 AND weight <> 4000) ORDER BY YEAR;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT year FROM cars_data WHERE weight BETWEEN 3000 AND 4000;

/*
Prediction Result:
(None,)
(34,)
*/