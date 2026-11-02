-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1038, 'sense');
INSERT INTO "continents" ("contid", "continent") VALUES (1048, 'table');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1039, 1038, 'Pakistan');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1049, 1048, 'Trinidad and Tobago');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1040, 1039, 'science', 'Gardner');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1050, 1049, 'according', 'Blake');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1041, 1040, 'discussion');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1051, 1050, 'collection');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1042, 'discussion', 'list');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1052, 'collection', 'save');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1042, 'perform', 1043, 1044.5, 'fall', 1045, 1046.5, 1047);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1052, 'knowledge', 1053, 1054.5, 'grow', NULL, 1056.5, 1057);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, YEAR FROM (SELECT YEAR, AVG(weight) AS meanweight FROM cars_data GROUP BY YEAR) ORDER BY avg_weight_, YEAR NULLS LAST;

/*
Gold Result:
(None, 1057)
(1045.0, 1047)
*/

-- Prediction Query
SELECT AVG(Weight), YEAR FROM CARS_DATA GROUP BY YEAR;

/*
Prediction Result:
(1045.0, 1047)
(None, 1057)
*/