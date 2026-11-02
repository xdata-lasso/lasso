-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (23, '25');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (21, NULL, NULL);
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (25, 23, '33');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (24, 25, '34', '35');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (29, NULL, '25');
INSERT INTO "car_names" ("makeid", "model", "make") VALUES (28, NULL, '25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT countryname, country AS countryid FROM (SELECT id, maker, fullname, country, countryname, continent, n, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent, RHS.n AS n FROM car_makers AS LHS INNER JOIN (SELECT countryid, countryname, continent, COUNT(*) OVER () AS n FROM countries) AS RHS ON (LHS.country = RHS.countryid))) WHERE (n >= 1) ORDER BY countryname, countryid NULLS LAST;

/*
Gold Result:
('33', '25')
*/

-- Prediction Query
SELECT T1.CountryName, T1.CountryId FROM COUNTRIES AS T1 JOIN CAR_MAKERS AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryId HAVING COUNT(*) >= 1;

/*
Prediction Result:
('33', 25)
*/