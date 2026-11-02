-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_code, region_name) VALUES (2, 'default1', 'default2');
INSERT INTO storm (storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths) VALUES (0, 'default2', NULL, 1, 1.0, 2);
INSERT INTO affected_region (region_id, storm_id, number_city_affected) VALUES (2, 0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, max_speed FROM (SELECT LHS.number_city_affected AS number_city_affected, LHS.storm_id AS storm_id, LHS.n AS n, RHS.storm_id AS storm_id_other, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd FROM (SELECT number_city_affected, storm_id, COUNT(*) AS n FROM affected_region GROUP BY number_city_affected, storm_id) AS LHS INNER JOIN storm AS RHS ON (LHS.storm_id = RHS.number_deaths)) ORDER BY name, max_speed NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.name, T1.max_speed FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id = T2.storm_id GROUP BY T1.storm_id ORDER BY COUNT(*) DESC, T1.name NULLS LAST, T1.max_speed NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2', 1)
*/