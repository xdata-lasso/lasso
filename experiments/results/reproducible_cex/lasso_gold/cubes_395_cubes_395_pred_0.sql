-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1135, 'discuss');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1136, 1135, 'Poland');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1137, 1136, 'garden', 'Cameron');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1138, 1137, 'stand');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1139, 'stand', 'term');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1140, 'stand', 'almost');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1141, 'stand', 'support');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1139, 'four', 1980, 1142.5, 'attorney', 1145, 1148.5, 1134);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1140, 'institution', 1980, 1151.5, 'development', 1158.0, 1163.5, 1134);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1141, 'executive', 1980, 1160.5, 'white', 1171.0, 1178.5, 1134);
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