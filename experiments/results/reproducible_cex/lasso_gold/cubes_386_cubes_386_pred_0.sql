-- Schema DDL
CREATE TABLE "continents" ("ContId" INTEGER PRIMARY KEY, "Continent" TEXT);

CREATE TABLE "countries" ("CountryId" INTEGER PRIMARY KEY, "Continent" INTEGER, "CountryName" TEXT, FOREIGN KEY ("Continent") REFERENCES "continents" ("ContId"));

CREATE TABLE "car_makers" ("Id" INTEGER PRIMARY KEY, "Country" TEXT, "Maker" TEXT, "FullName" TEXT, FOREIGN KEY ("Country") REFERENCES "countries" ("CountryId"));

CREATE TABLE "model_list" ("ModelId" INTEGER PRIMARY KEY, "Maker" INTEGER, "Model" TEXT UNIQUE, FOREIGN KEY ("Maker") REFERENCES "car_makers" ("Id"));

CREATE TABLE "car_names" ("MakeId" INTEGER PRIMARY KEY, "Model" TEXT, "Make" TEXT, FOREIGN KEY ("Model") REFERENCES "model_list" ("Model"));

CREATE TABLE "cars_data" ("Id" INTEGER PRIMARY KEY, "MPG" TEXT, "Cylinders" INTEGER, "Edispl" REAL, "Horsepower" TEXT, "Weight" INTEGER, "Accelerate" REAL, "Year" INTEGER, FOREIGN KEY ("Id") REFERENCES "car_names" ("MakeId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "continents" ("contid", "continent") VALUES (1013, 'discover');
INSERT INTO "continents" ("contid", "continent") VALUES (1014, 'early');
INSERT INTO "continents" ("contid", "continent") VALUES (1015, 'mouth');
INSERT INTO "continents" ("contid", "continent") VALUES (1016, 'play');
INSERT INTO "continents" ("contid", "continent") VALUES (1025, 'sure');
INSERT INTO "continents" ("contid", "continent") VALUES (1026, 'collection');
INSERT INTO "continents" ("contid", "continent") VALUES (1027, 'save');
INSERT INTO "continents" ("contid", "continent") VALUES (1028, 'knowledge');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1017, 1013, 'Anguilla');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1018, 1013, 'Monaco');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1019, 1013, 'Congo');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1020, 1013, 'Saint Barthelemy');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1029, 1025, 'Guam');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1030, 1025, 'Fiji');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1031, 1025, 'Cape Verde');
INSERT INTO "countries" ("countryid", "continent", "countryname") VALUES (1032, 1025, 'Cuba');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1021, 1017, 'rate', 'Robinson');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1022, 1017, 'science', 'Lawrence');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1023, 1017, 'offer', 'Pacheco');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1024, 1017, 'kind', 'Smith');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1033, 1029, NULL, 'James');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1034, 1029, NULL, 'Howard');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1035, 1029, NULL, 'Cooper');
INSERT INTO "car_makers" ("id", "country", "maker", "fullname") VALUES (1036, 1029, NULL, 'Baker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT countryname FROM (SELECT * FROM (SELECT * FROM (SELECT id, maker, fullname, country, countryname, continent, countryid, COUNT(*) OVER () AS n FROM (SELECT id, maker, fullname, country, countryname, continent, country AS countryid FROM (SELECT LHS.id AS id, LHS.maker AS maker, LHS.fullname AS fullname, LHS.country AS country, RHS.countryname AS countryname, RHS.continent AS continent FROM car_makers AS LHS INNER JOIN countries AS RHS ON (LHS.country = RHS.countryid)))) ORDER BY continent DESC) LIMIT 1);

/*
Gold Result:
('Guam',)
*/

-- Prediction Query
SELECT T2.CountryName FROM CAR_MAKERS AS T1 JOIN COUNTRIES AS T2 ON T1.Country = T2.CountryId GROUP BY T1.Country ORDER BY COUNT(*) DESC, T2.CountryName NULLS LAST LIMIT 1;

/*
Prediction Result:
('Anguilla',)
*/