-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_code, region_name) VALUES (10, 'default1', NULL), (9, 'default1', NULL), (0, 'default1', 'default2'), (1, 'default1', NULL), (11, 'default1', NULL), (2, 'default2', NULL);
INSERT INTO storm (storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths) VALUES (0, NULL, NULL, NULL, 10.0, 1), (9, 'default2', 'default1', 11, NULL, 10), (1, 'default1', NULL, 0, 1.0, 11), (11, NULL, 'default1', 1, 1.0, 11), (10, NULL, 'default2', 9, 0.0, 10), (2, NULL, 'default2', 10, 0.0, 11);
INSERT INTO affected_region (region_id, storm_id, number_city_affected) VALUES (11, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.number_city_affected AS number_city_affected FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, RHS.region_id AS region_id, RHS.region_code AS region_code, RHS.region_name AS region_name FROM storm AS LHS CROSS JOIN region AS RHS) AS LHS INNER JOIN affected_region AS RHS ON (LHS.storm_id = RHS.storm_id AND LHS.region_id = RHS.region_id)) WHERE (number_deaths > 10) ORDER BY region_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id WHERE T3.number_deaths >= 10;

/*
Prediction Result:
(None,)
*/