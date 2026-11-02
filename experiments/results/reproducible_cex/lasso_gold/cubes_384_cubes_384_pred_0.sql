-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1147, 'onto');
INSERT INTO "continents" ("contid", "continent") VALUES (1157, 'drop');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1148, 1147, 'Cyprus');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1158, 1157, 'Swaziland');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1149, 1148, 'reveal', 'Nguyen');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1159, 1158, 'almost', 'Trujillo');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1150, 1149, 'special');
INSERT INTO "model_list" ("modelid", "maker", "model") VALUES (1160, 1159, 'institution');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1151, 'special', 'amc hornet sportabout (sw)');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (1161, 'institution', 'amc hornet sportabout (sw)');
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1151, 'executive', 1152, 1153.5, 'arrive', 1154, 1156.5, 1156);
INSERT INTO "cars_data" ("id", "mpg", "cylinders", "edispl", "horsepower", "weight", "accelerate", "year") VALUES (1161, 'stand', 1153, 1154.5, 'attorney', 1155, 1155.5, 1157);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "accelerate" FROM (SELECT "LHS"."makeid" AS "makeid", "LHS"."model" AS "model", "LHS"."make" AS "make", "RHS"."mpg" AS "mpg", "RHS"."cylinders" AS "cylinders", "RHS"."edispl" AS "edispl", "RHS"."horsepower" AS "horsepower", "RHS"."weight" AS "weight", "RHS"."accelerate" AS "accelerate", "RHS"."year" AS "year" FROM (SELECT * FROM "car_names" WHERE ("make" = 'amc hornet sportabout (sw)')) AS LHS INNER JOIN cars_data AS RHS ON (LHS.makeid = RHS.id)) ORDER BY accelerate, "accelerate" NULLS LAST;

/*
Gold Result:
(1155.5,)
(1156.5,)
*/

-- Prediction Query
SELECT T1.Accelerate FROM CARS_DATA AS T1 JOIN CAR_NAMES AS T2 ON T1.Id = T2.MakeId WHERE T2.Make = 'amc hornet sportabout (sw)';

/*
Prediction Result:
(1156.5,)
(1155.5,)
*/