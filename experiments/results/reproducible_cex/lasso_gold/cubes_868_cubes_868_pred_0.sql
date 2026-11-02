-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1008, 'begin', 'Amanda Davis');
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1029, 'throw', NULL);
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1009, 'Lance Hoffman', 'sense', 1010, 1011.5, 1012);
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1030, 'Calvin Nielsen', 'bar', 1031, 1032.5, 1033);
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1008, 1009, 1013.5);
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1029, 1030, 1034.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name, n AS count___ FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, LHS.storm_id AS storm_id, LHS.number_city_affected AS number_city_affected, RHS.n AS n FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id, RHS.number_city_affected AS number_city_affected FROM region AS LHS INNER JOIN affected_region AS RHS ON (LHS.region_id = RHS.region_id)) AS LHS INNER JOIN (SELECT region_id, COUNT(*) AS n FROM affected_region GROUP BY region_id) AS RHS ON (LHS.region_id = RHS.region_id)) ORDER BY region_name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Amanda Davis', 1)
*/

-- Prediction Query
SELECT T1.region_name, COUNT(*) FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id;

/*
Prediction Result:
('Amanda Davis', 1)
(None, 1)
*/