-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1001, 'purpose');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1002, 1001, 'Bouvet Island (Bouvetoya)');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1003, 1002, 'ago', 'Figueroa');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1004, 1003, 'election');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1005, 'election', 'dog');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1005, 'chair', 1006, 1007.5, 'since', 0, 1008.5, 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM cars_data WHERE (weight <> 3000 AND weight <> 4000) ORDER BY YEAR;

/*
Gold Result:
(1009,)
*/

-- Prediction Query
SELECT DISTINCT year FROM cars_data WHERE weight BETWEEN 3000 AND 4000;

/*
Prediction Result:
*/