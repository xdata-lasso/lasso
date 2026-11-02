-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 1000.01, 'pgu7vfe4');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483647, 'uzhsrwbbp6lu', 'hvdlttilbnpr', 986.066566, 1000.01, 'dposiie5unw');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (3, '76nium52', 'zbuo4nrqrof', 586.906897, 1000.01, 'p5s5bbp');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (2, '02eutliqa11r', 'ytoo3o9', 111.926013, 731.301441, '72klex14ji7z');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (4, '5k5swwqcgs', '9n8', 874.871895, NULL, 'pgu7vfe4');

-- Inserting into table: farm_competition --
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (-2147483648, 1, 1160656988, 't2__1b9738', 'ia2yp');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (2, 1, -1399556171, 't2__1b9738', 'a9000t5c4eci');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (3, 1, 1149850321, 't2__1b9738', 'e');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (-2147483645, 2, -2081315180, 't2__1b9738', '2dwyrq13pyu7');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (-2147483644, 2, 244829661, 't2__1b9738', 'jsl');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (-2147483643, 2, -346339240, 't2__1b9738', 'yp5qi2rk');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (-2147483642, 1, -705985602, 't2__1b9738', 'x58pz0f8je');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (-2147483641, 1, 1196308825, NULL, 'd21vy9uxj4hw');

INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (4, 4, 1160656988, 'ia2yp', 'uzhsrwbbp6lu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM (SELECT LHS.city_id AS city_id, LHS.official_name AS official_name, LHS.status AS status, LHS.area_km_2 AS area_km_2, LHS.population AS population, LHS.census_ranking AS census_ranking, RHS.year AS YEAR, RHS.theme AS theme, RHS.host_city_id AS host_city_id, RHS.hosts AS hosts FROM (SELECT * FROM city WHERE (population > 1000.0)) AS LHS INNER JOIN farm_competition AS RHS ON (LHS.city_id = RHS.competition_id)) ORDER BY theme;

/*
Gold Result:
('t2__1b9738',)
*/

-- Prediction Query
SELECT T2.Theme FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID = T2.Host_city_ID WHERE T1.Population > 1000;

/*
Prediction Result:
('t2__1b9738',)
('t2__1b9738',)
(None,)
('t2__1b9738',)
('t2__1b9738',)
*/