-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'Storm A', '2020-01', 100, 10.5, 10);
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'R1', 'Region One');
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (1, 1, 5.0);
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
('Region One',)
*/