-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1015, 'offer');
INSERT INTO "continents" ("contid", "continent") VALUES (1029, 'decide');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1016, 1015, 'Benin');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1030, 1029, 'Saint Barthelemy');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1017, 1016, 'performance', 'Henderson');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1031, 1030, 'rate', 'Miles');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1018, 1017, 'all');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1019, 1017, 'better');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1020, 1017, 'discover');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1021, 1017, 'early');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1032, 1031, 'kind');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1033, 1031, 'discussion');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1034, 1031, 'list');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1035, 1031, 'perform');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1025, 'all', 'mouth');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1026, 'all', 'play');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1027, 'all', 'agreement');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1028, 'all', 'option');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1039, NULL, 'fall');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1040, NULL, 'table');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1041, NULL, 'true');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1042, NULL, 'according');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT model FROM (SELECT * FROM (SELECT * FROM (SELECT model, COUNT(*) AS n FROM car_names GROUP BY model) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Model FROM CAR_NAMES GROUP BY Model ORDER BY COUNT(*) DESC, Model NULLS LAST LIMIT 1;

/*
Prediction Result:
('all',)
*/