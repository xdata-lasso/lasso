-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (14, '1');
INSERT INTO "continents" ("contid", "continent") VALUES (13, '1');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (16, 13, '1');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (18, 16, '1', '1');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (17, NULL, '1', '1');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (20, 17, '12');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (19, 17, '11');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (21, 11, '1');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (22, 12, '1');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (22, '25', 892, 26, '27', 28, 29, 30);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (21, '31', 891, 32, '33', 34, 35, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT cylinders, COUNT(*) AS n FROM cars_data GROUP BY cylinders) WHERE (cylinders > 6 OR n = 6) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders > 6;

/*
Prediction Result:
(2,)
*/