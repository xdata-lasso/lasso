-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: storm --
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483648, '9n8', '4', -734455130, 906.21648, -1633151678);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483647, 'ypuzhsrw', 'b', 1072996612, 503.083789, -1659388584);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483646, 'n', 'rmdp', 2026480202, 133.007885, -1823627488);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483645, '6klfa9', '00t5c4e', 1274489983, 128.76421, -1683203397);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483644, '5bbp0', '2eutliqa11r', 2137741668, 881.232072, -525979501);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483643, 'o3o9hl72klex', '4ji7zwa', 2123196517, 920.013763, 364869063);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483642, '3pyu78d99r', 'jsl', -346339240, 470.165282, 1692174491);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483641, '2rk', '9v', 556727997, 860.770887, 1178000634);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483640, 'z0f8jegd21vy', '9uxj4hwbdvl', 2103044118, 705.754562, -1642259219);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483639, 'q', 'nqcx5h', -1245312912, 866.804244, -988981234);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483638, 'jg', '8n2f3', 806170397, 656.638403, 513454646);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483637, 'cb', '8ozk3zbil', 982314585, 279.382219, 638024588);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483636, 'ah0f8jsww', 'q7x', -541746689, 584.342044, 1294666887);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483635, 'z16ni', 'jai', 1746373317, 62.386264, 1360271423);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483634, 'grgj', '8', -458359144, 639.801051, 1568069663);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483633, 'go', 'ri', -902895762, 453.914926, 2111987706);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483632, '4301j', '3d', -1826414375, 544.095565, 357330522);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (-2147483631, 'x8vacx7af', '5w1of7', 76996700, 398.637058, 1992637800);

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1, '5k5swwqcgs', 't1__c206ac');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (-2147483647, 'tti', 't1__c206ac');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (2, '76nium52', 't1__c206ac');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (4, 'u', '4nrq');

-- Inserting into table: affected_region --
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483648, 134.487977);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483647, 855.355181);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483646, 327.753528);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483645, 623.093099);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483645, 597.420508);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483647, 680.514642);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483646, 389.878901);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483644, 668.928822);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483643, 278.010437);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483642, 495.297639);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483641, 541.393553);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (4, -2147483640, 109.083092);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483639, 304.188492);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483642, 57.96362);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483640, 552.472052);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483638, 339.762162);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483637, 692.775559);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483643, 34.258887);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483636, 379.883722);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483635, 488.601669);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483634, 959.056025);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483633, 360.694313);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483632, 565.286158);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, -2147483631, 308.935851);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id FROM region AS LHS INNER JOIN (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS RHS ON (LHS.region_id = RHS.n)) ORDER BY region_name;

/*
Gold Result:
('t1__c206ac',)
*/

-- Prediction Query
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('t1__c206ac',)
('4nrq',)
*/