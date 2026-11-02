-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1022, 'all');
INSERT INTO "continents" ("contid", "continent") VALUES (1032, 'sense');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1023, 1022, 'Bermuda');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1033, 1032, 'Pakistan');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1024, 1023, 'discover', 'Hall');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1034, 1033, 'science', 'Gardner');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1025, 1024, 'play');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1035, 1034, 'discussion');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1026, 'play', 'agreement');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1036, 'discussion', 'list');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1026, 'option', 1027, 1028.5, 'decide', 1029, 1030.5, 1031);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1036, 'perform', 1037, 1038.5, 'fall', 1039, NULL, 1041);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxaccelerate AS max_accelerate_, cylinders FROM (SELECT cylinders, MAX(accelerate) AS maxaccelerate FROM cars_data GROUP BY cylinders) ORDER BY max_accelerate_, cylinders NULLS LAST;

/*
Gold Result:
(None, 1037)
(1030.5, 1027)
*/

-- Prediction Query
SELECT MAX(Accelerate), Cylinders FROM CARS_DATA GROUP BY Cylinders;

/*
Prediction Result:
(1030.5, 1027)
(None, 1037)
*/