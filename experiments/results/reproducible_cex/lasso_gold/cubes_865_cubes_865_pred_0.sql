-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1007, 'begin', 'Amanda Davis');
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1013, 'rate', 'Jennifer Cole');
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1008, 'Lance Hoffman', 'sense', 1009, 1010.5, 1011);
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1014, NULL, 'collection', 1015, 1016.5, 1017);
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1007, 1008, 1012.5);
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1013, 1014, 1018.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.storm_id AS storm_id, LHS.n AS n, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.number_deaths AS number_deaths FROM (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS LHS INNER JOIN storm AS RHS ON (LHS.storm_id = RHS.storm_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Lance Hoffman', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id = T2.storm_id GROUP BY T1.storm_id;

/*
Prediction Result:
('Lance Hoffman', 1)
(None, 1)
*/