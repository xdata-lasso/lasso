-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: continents --
INSERT INTO "continents" ("contid", "continent") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: countries --
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (-2147483648, -2147483648, '9n8');

-- Inserting into table: car_makers --
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (-2147483648, '-2147483648', '4', 'gu7v');

-- Inserting into table: model_list --
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (-2147483648, -2147483648, 'model_1');

-- Inserting into table: car_names --
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483648, 'model_1', 'e4');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483647, 'model_1', 'dpos');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483646, 'model_1', 'c4ecigce');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483645, 'model_1', '5bbp0');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483644, 'model_1', 'ji7zwau2');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483643, 'model_1', 'f9v');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483642, 'model_1', 'j4hwbd');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483641, 'model_1', 'jtu0d');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483640, 'model_1', '9');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483639, 'model_1', 'lq7xb7');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483638, 'model_1', 'grgj');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483637, 'model_1', '3ay');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483636, 'model_1', 'afu5w1of7');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483635, 'model_1', '8507cvtjp');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483634, 'model_1', '0');

-- Inserting into table: cars_data --
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483648, 'hria2ypuzhs', 1, 663.049759, 'wbbp6luhvdlt', -841692980, 182.319045, -1257178728);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483647, 'ie5', 1, 327.753528, 'w6kl', 1620389964, 627.258639, 947159877);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483646, '76nium52', 1, 816.814398, 'buo4nrq', 418417917, 220.906948, -1031969798);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483645, '2eutliqa11r', 1, 997.73177, 'ytoo3o9hl7', 1178636309, 176.308171, 1055976837);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483644, 'dwyrq13pyu78', 1, 49.538289, 'rljsl0b4y', -1116181514, 792.401003, -1555456236);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483643, 'x58pz', 1, 410.133844, '8j', -1937207087, 890.091601, -688509700);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483642, 'lph2gn', NULL, 58.749749, 'wnqcx', 722884590, 635.267184, -1245312912);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483641, '79fjgq8', NULL, 915.268032, '2f3d', 513454646, 339.762162, 331812443);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483640, 'ozk3zbily', NULL, 279.382219, 'n6v', -1672720816, 92.94508, -1520489792);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483639, '2fxa7ryfdrz', 1, 753.351134, '6nijjai', 1746373317, 62.386264, 1360271423);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483638, '8', 1, 740.059813, 'zt1afgo', -1696173285, 127.371696, 710458518);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483637, 'p1q430', 1, 947.945777, 'jh3den8c68', -683007527, 757.137864, 2035306060);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483636, 'pzo72ctdc', 1, 803.582738, 'mfg62g0v5q8q', -1488156735, 67.250709, -1180042408);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483635, 'ttg6bnou5zi3', 1, 510.534763, '4', -2072838897, 166.297151, -1173368267);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483634, '7z2zezjo7wg', 1, 790.772456, '5', -526612570, 372.754231, -405743609);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT cylinders, COUNT(*) AS n FROM cars_data GROUP BY cylinders) WHERE (cylinders > 6 OR n = 6) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders > 6;

/*
Prediction Result:
(0,)
*/