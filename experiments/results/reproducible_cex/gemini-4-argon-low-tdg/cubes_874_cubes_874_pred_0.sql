-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'R1', 'North');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (2, 'R2', 'South');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (3, 'R3', 'East');
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (10, 'Alpha', 'Jan', 100, 5.0, 20);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (20, 'Beta', 'Feb', 150, 10.0, 10);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (30, 'Gamma', 'Mar', 200, 15.0, 10);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (1, 10, 5.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (2, 10, 5.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (3, 10, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, max_speed FROM (SELECT LHS.number_city_affected AS number_city_affected, LHS.storm_id AS storm_id, LHS.n AS n, RHS.storm_id AS storm_id_other, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd FROM (SELECT number_city_affected, storm_id, COUNT(*) AS n FROM affected_region GROUP BY number_city_affected, storm_id) AS LHS INNER JOIN storm AS RHS ON (LHS.storm_id = RHS.number_deaths)) ORDER BY name, max_speed NULLS LAST;

/*
Gold Result:
('Beta', 150)
('Beta', 150)
('Gamma', 200)
('Gamma', 200)
*/

-- Prediction Query
SELECT T1.name, T1.max_speed FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id = T2.storm_id GROUP BY T1.storm_id ORDER BY COUNT(*) DESC, T1.name NULLS LAST, T1.max_speed NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha', 100)
*/