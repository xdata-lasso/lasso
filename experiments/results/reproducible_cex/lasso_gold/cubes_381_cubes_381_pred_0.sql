-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1352, 'shoulder');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1353, 1352, 'Austria');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1354, 1353, 'report', 'Valdez');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1355, 1354, 'race');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1356, 'race', 'such');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1357, 'race', 'training');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1358, 'race', 'boy');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1359, 'race', 'energy');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1360, 'race', 'dark');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1361, 'race', 'customer');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1356, 'not', 6, 1362.5, 'maintain', 1368, 1374.5, 1380);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1357, 'list', 6, 1371.5, 'enjoy', 1381.0, 1389.5, 1397.0);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1358, 'challenge', 6, 1380.5, 'two', 1394.0, 1404.5, 1414.0);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1359, 'knowledge', 6, 1389.5, 'wind', 1407.0, 1419.5, 1431.0);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1360, 'cover', 6, 1398.5, 'bag', 1420.0, 1434.5, 1448.0);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1361, 'family', 6, 1407.5, 'level', 1433.0, 1449.5, 1465.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT cylinders, COUNT(*) AS n FROM cars_data GROUP BY cylinders) WHERE (cylinders > 6 OR n = 6) ORDER BY count___;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders > 6;

/*
Prediction Result:
(0,)
*/