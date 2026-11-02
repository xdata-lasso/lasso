-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1001, 'purpose');
INSERT INTO "continents" ("contid", "continent") VALUES (1002, 'brother');
INSERT INTO "continents" ("contid", "continent") VALUES (1003, 'ago');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1004, 1001, 'Saint Vincent and the Grenadines');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1005, 1001, 'Falkland Islands (Malvinas)');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1006, 1001, 'Ecuador');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1007, 1004, 'dog', 'Garcia');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1008, 1004, 'chair', 'Yang');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1009, 1004, 'since', 'Gardner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT countryname, country AS countryid FROM (SELECT id, maker, fullname, country, countryname, continent, n, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent, RHS.n AS n FROM car_makers AS LHS INNER JOIN (SELECT countryid, countryname, continent, COUNT(*) OVER () AS n FROM countries) AS RHS ON (LHS.country = RHS.countryid))) WHERE (n >= 1) ORDER BY countryname, countryid NULLS LAST;

/*
Gold Result:
('Saint Vincent and the Grenadines', '1004')
*/

-- Prediction Query
SELECT T1.CountryName, T1.CountryId FROM COUNTRIES AS T1 JOIN CAR_MAKERS AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryId HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Saint Vincent and the Grenadines', 1004)
*/