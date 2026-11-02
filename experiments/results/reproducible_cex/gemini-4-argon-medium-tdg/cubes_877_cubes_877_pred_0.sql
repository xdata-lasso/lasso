-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by storm_id vs region_id (Storm 10 has count 1, Storm 20 has count 2).
-- 2. Joining on region_id = n vs region_id = storm_id (Storm_IDs are 10, 20; Region_ids are 1, 2, 3, 10, 20).
-- 3. COUNT(*) vs COUNT(Number_city_affected) when Number_city_affected is NULL.
-- 4. COUNT(*) vs SUM(Number_city_affected) when Number_city_affected is 5.0.
-- 5. Ordering (Zeta vs Alpha) and unmatched regions (Gamma, Delta, Epsilon).
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (10, 'StormA', 'Jan', 100, 10.5, 2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (20, 'StormB', 'Feb', 120, 20.0, 5);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (30, 'StormC', 'Mar', 80, 1.0, 0);
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'C_ZETA', 'Zeta');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (2, 'C_ALPHA', 'Alpha');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (3, 'C_GAMMA', 'Gamma');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (10, 'C_DELTA', 'Delta');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (20, 'C_EPSILON', 'Epsilon');
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 10, 5.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 20, NULL);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (20, 20, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id FROM region AS LHS INNER JOIN (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS RHS ON (LHS.region_id = RHS.n)) ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Delta',)
*/