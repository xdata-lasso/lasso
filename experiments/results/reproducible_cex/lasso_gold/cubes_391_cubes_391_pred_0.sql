-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1009, 'wait');
INSERT INTO "continents" ("contid", "continent") VALUES (1013, 'all');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1010, 1009, 'Mayotte');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1014, 1013, 'Bermuda');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1012, 1010, 'begin', 'Garza');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1011, 1014, 'discover', 'Hall');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1012, 1012, 'almost');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1016, 1011, 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maker, model FROM model_list ORDER BY maker, model_list.modelid NULLS LAST;

/*
Gold Result:
(1011, 'play')
(1012, 'almost')
*/

-- Prediction Query
SELECT Maker, Model FROM MODEL_LIST;

/*
Prediction Result:
(1012, 'almost')
(1011, 'play')
*/