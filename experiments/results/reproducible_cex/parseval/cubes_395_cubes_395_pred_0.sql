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

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483647, 'model_1', 'hvdlttilbnpr');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483646, 'model_1', '00t5c4ecigc');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483645, 'model_1', 'p5s5bbp');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483644, 'model_1', 'ex1');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483643, 'model_1', '0b4');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483642, 'model_1', 'y9uxj4');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483641, 'model_1', 'x');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483640, 'model_1', '0gcb98');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483639, 'model_1', '7xb72');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483638, 'model_1', '6nijjai5dh');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483637, 'model_1', 'p1q430');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483636, 'model_1', '7pzo72ctd');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483635, 'model_1', 'o22');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483634, 'model_1', 'i36c4bf');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483633, 'model_1', 'xd');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483632, 'model_1', 'npi');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483631, 'model_1', 'v8u');

-- Inserting into table: cars_data --
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483648, 'hria2ypuzhs', 700293388, 711.020062, 'b', 1072996612, 503.083789, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483647, 'dpos', -1576219117, 75.403642, 'nw6klf', 1038707349, 587.783596, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483646, 'e376nium52', -443340271, 676.357279, '4nrq', 418417917, 220.906948, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483645, '02eutliqa11r', 2137741668, 881.232072, 'too3o9h', 90119032, 958.92567, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483644, 'ji7zwau2', 364869063, 278.010437, '3pyu78d', -977635379, 145.402595, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483643, 'p5qi2rk', -705985602, 604.643336, 'x58pz0f8jeg', 910894705, 452.27611, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483642, 'wb', -1929953647, 185.427628, 'h2gn', 1968874827, 345.35543, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483641, '5hncprjtu0d', 401805964, 154.065416, '8n2f3', 806170397, 656.638403, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483640, 'zk3z', 1686459626, 138.057338, 'yrkn6vck6ah0', -1520489792, 346.706184, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483639, 'xa', 1294666887, 379.883722, 'r', 777149609, 753.351134, NULL);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483638, 'ogrgjd8y', 1129658414, 308.482994, 'afgogri', -902895762, 453.914926, NULL);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483637, 'jh3den8', 195720193, 897.348977, 'vacx7afu5', -290314193, 850.85096, NULL);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483636, 't', -1284905200, 102.360106, '2g0v5q8qd', 569007824, 234.606624, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483635, '8507cvtjp', 1582582341, 605.666938, '6b', -1171104889, 813.864654, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483634, 'foa', 382831862, 60.937725, '7z2zezj', 1448731351, 523.290303, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483633, 'ysxcmr0o', 853709925, 297.258735, 'j5', -1609653472, 172.799686, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483632, '5k58', -1125548818, 848.622384, '4gth2mnaj', -1478011227, 11.892553, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483631, 'tmu2n', -1817527403, 572.833475, 'lfvyz7zzb', 924693315, 335.639672, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM cars_data GROUP BY YEAR) WHERE (YEAR = 1980 AND n <= 1980) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM CARS_DATA WHERE YEAR = 1980;

/*
Prediction Result:
(0,)
*/