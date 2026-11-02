-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (21, NULL, 'Denmark29', 30, 31, 32);
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (39, NULL, 'Denmark27');
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (37, 'Denmark33', 'Denmark');
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (37, 21, 36);
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (39, 21, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."storm_id" AS "storm_id", "LHS"."name" AS "name", "LHS"."dates_active" AS "dates_active", "LHS"."max_speed" AS "max_speed", "LHS"."damage_millions_usd" AS "damage_millions_usd", "LHS"."number_deaths" AS "number_deaths", "LHS"."region_id" AS "region_id", "LHS"."region_code" AS "region_code", "LHS"."region_name" AS "region_name", "RHS"."number_city_affected" AS "number_city_affected" FROM (SELECT "LHS"."storm_id" AS "storm_id", "LHS"."name" AS "name", "LHS"."dates_active" AS "dates_active", "LHS"."max_speed" AS "max_speed", "LHS"."damage_millions_usd" AS "damage_millions_usd", "LHS"."number_deaths" AS "number_deaths", "RHS"."region_id" AS "region_id", "RHS"."region_code" AS "region_code", "RHS"."region_name" AS "region_name" FROM "storm" AS "LHS" CROSS JOIN "region" AS "RHS") AS "LHS" INNER JOIN "affected_region" AS "RHS" ON ("LHS"."storm_id" = "RHS"."storm_id" AND "LHS"."region_id" = "RHS"."region_id")) WHERE ("region_name" = 'Denmark') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T3.name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id WHERE T2.region_name = 'Denmark';

/*
Prediction Result:
(None,)
*/