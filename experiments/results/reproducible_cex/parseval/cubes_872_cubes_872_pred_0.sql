-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: storm --
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1, '5k5swwqcgs', '9n8', 1610062532, 475.173408, 10);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483647, '4h', 'ia2yp', -1670923962, 663.049759, 10);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (2, 'w6kl', 'a9', 1620389964, 627.258639, 10);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (3, '0t5c4ecigc', 'e376nium52', -443340271, 676.357279, -1179823637);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (4, '5k5swwqcgs', '9n8', 1610062532, 475.173408, NULL);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (5, '5k5swwqcgs', '9n8', 1610062532, 475.173408, 10);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (6, 'luhvdltti', 'bnp', 1236688122, 986.066566, 10);

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1, 'u7', 't2__b6d285');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (2, 'wbbp6luhvdlt', 't2__b6d285');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483647, 'ilbnp', 't2__b6d285');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (3, 'dpos', 'ie5');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (4, 'u7', 'fe4hri');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (5, 'u7', 'fe4hri');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483642, 'a2ypuzhsrwbb', NULL);

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (6, 'dposiie5unw', 'klfa9000t');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483640, 'c4ecigce', NULL);

-- Inserting into table: affected_region --
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, 1, 328.996339);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (2, 1, 787.938887);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (3, 1, 327.753528);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, 3, 760.580899);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, 4, 710.998147);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (5, 5, 749.826493);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (6, 6, 467.07027);
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
('t2__b6d285',)
('t2__b6d285',)
('ie5',)
('fe4hri',)
('klfa9000t',)
*/