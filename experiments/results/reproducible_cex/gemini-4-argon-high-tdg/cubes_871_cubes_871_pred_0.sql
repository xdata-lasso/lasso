-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'Zeta', '2020-01-01', 120, 15.5, 2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (2, 'Beta', '2020-02-01', 100, 5.0, 0);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (3, 'Alpha', '2020-03-01', 140, 25.0, 5);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (4, 'Gamma', '2020-04-01', 90, 1.2, 1);
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (10, 'DK', 'Denmark');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (20, 'SE', 'Sweden');
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 1, 4.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 2, 2.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 3, 6.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (20, 4, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."storm_id" AS "storm_id", "LHS"."name" AS "name", "LHS"."dates_active" AS "dates_active", "LHS"."max_speed" AS "max_speed", "LHS"."damage_millions_usd" AS "damage_millions_usd", "LHS"."number_deaths" AS "number_deaths", "LHS"."region_id" AS "region_id", "LHS"."region_code" AS "region_code", "LHS"."region_name" AS "region_name", "RHS"."number_city_affected" AS "number_city_affected" FROM (SELECT "LHS"."storm_id" AS "storm_id", "LHS"."name" AS "name", "LHS"."dates_active" AS "dates_active", "LHS"."max_speed" AS "max_speed", "LHS"."damage_millions_usd" AS "damage_millions_usd", "LHS"."number_deaths" AS "number_deaths", "RHS"."region_id" AS "region_id", "RHS"."region_code" AS "region_code", "RHS"."region_name" AS "region_name" FROM "storm" AS "LHS" CROSS JOIN "region" AS "RHS") AS "LHS" INNER JOIN "affected_region" AS "RHS" ON ("LHS"."storm_id" = "RHS"."storm_id" AND "LHS"."region_id" = "RHS"."region_id")) WHERE ("region_name" = 'Denmark') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT T3.name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id WHERE T2.region_name = 'Denmark';

/*
Prediction Result:
('Zeta',)
('Beta',)
('Alpha',)
*/