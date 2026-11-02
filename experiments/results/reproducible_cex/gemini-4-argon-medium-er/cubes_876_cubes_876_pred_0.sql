-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'S1', '2020', 100, 10.0, 0);
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'RC1', 'R1');
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (1, 1, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT LHS.region_id AS region_id, LHS.storm_id AS storm_id, LHS.number_city_affected AS number_city_affected, RHS.storm_id AS storm_id_other, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.region_code AS region_code, RHS.region_name AS region_name FROM affected_region AS LHS INNER JOIN (SELECT storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths, region_code, region_name, number_deaths AS region_id FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, RHS.region_code AS region_code, RHS.region_name AS region_name FROM storm AS LHS INNER JOIN region AS RHS ON (LHS.number_deaths = RHS.region_id))) AS RHS ON (LHS.storm_id = RHS.number_deaths AND LHS.region_id = RHS.region_id)) ORDER BY region_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id ORDER BY T3.Number_Deaths DESC, T1.region_id NULLS LAST, T1.storm_id NULLS LAST, T2.region_id NULLS LAST, T3.storm_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('R1',)
*/