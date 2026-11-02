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
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (2, 'model_1', 'e4');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (3, 'model_1', 'hvdltt');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483646, 'model_1', '5sw');

INSERT INTO "car_names" ("makeid", "model", "make") VALUES (-2147483645, 'model_1', 'hria2ypuzhs');

-- Inserting into table: cars_data --
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (2, 'hria2ypuzhs', 700293388, 711.020062, 'b', 1, 749.826493, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (3, 'lbn', 462974032, 792.223623, 'posiie5unw6k', 1, 768.216462, 1);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483646, 'qcgsk9', 1610062532, 475.173408, 'u7', -734455130, 906.21648, 2);

INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (-2147483645, 'rwbbp6luhvd', -1377057208, 304.02808, 'bnp', 1236688122, 986.066566, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM cars_data WHERE (weight <> 3000 AND weight <> 4000) ORDER BY YEAR;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT year FROM cars_data WHERE weight BETWEEN 3000 AND 4000;

/*
Prediction Result:
*/