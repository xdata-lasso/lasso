-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: storm --
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1, '5k5swwqcgs', '9n8', 1610062532, 475.173408, 1871297066);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483647, 'nw6klf', 'a9000t5c4eci', 1149850321, 44.682291, -1833165707);

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483648, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483647, 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483646, 'dpos', 'ie5');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483645, 'nium52zbu', '4nrq');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483644, 'fqyp', 's5bbp02e');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483643, 'liqa1', 'ryytoo3');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483642, 'hl72klex1', 'ji7zwau2');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483641, 'w', 'yrq13pyu78d9');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483640, 'jsl', 'b4yp5qi');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483639, 'kf9vq', 'x58pz0f8je');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483638, 'd21vy9uxj4hw', 'd');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483637, 'ph2', 'nd');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483636, 'nqcx5h', 'cprj');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483635, '0dz79f', 'gq8');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483634, '2f3d', 'qv0gcb98ozk');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483633, 'bilyrkn', '6vck6ah0f8js');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483632, 'lq7xb7', '2fxa7ryfdrz');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483631, '6nijjai5dh', 'ogrgjd8y');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483630, '1afgo', 'ri');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483629, 'sj3ayxp1q430', 'jh3den8');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483628, 'c68x8vacx7', 'f');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483627, 'w1of77pz', '72ct');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483626, 't', 'mfg62g0v5q8q');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483625, 'jpe1io22785', '7cvtjpt');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483624, 'g6bno', '5zi36c');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483623, 'f', 'foa');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483622, 'cd07z2zezj', '7wgx');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483621, 'ysxcmr0o', 'ztdgj5i3lq5l');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483620, 'pim5', '58q');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483619, '27p2r', '4gth2mnaj');

-- Inserting into table: affected_region --
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483648, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483647, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483646, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483645, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483644, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483643, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483642, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483641, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483640, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483639, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483638, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483637, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483636, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483635, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483634, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483633, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483632, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483631, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483630, 1, NULL);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483629, 1, NULL);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483628, 1, NULL);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483627, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483626, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483625, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483624, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483623, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483622, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483621, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483620, 1, 1.0);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (-2147483619, 1, 1.0);
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
('5k5swwqcgs', 1610062532)
*/