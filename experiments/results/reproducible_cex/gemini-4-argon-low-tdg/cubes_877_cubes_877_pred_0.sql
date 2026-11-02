-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'R1', 'Zebra');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (2, 'R2', 'Apple');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (3, 'R3', 'Mango');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (4, 'R4', 'Banana');
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (10, 'Storm_A', 'Jan', 100, 1.5, 0);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (20, 'Storm_B', 'Feb', 120, 2.5, 1);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (30, 'Storm_C', 'Mar', 140, 3.5, 2);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (3, 10, 5.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (4, 10, 10.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (4, 20, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id FROM region AS LHS INNER JOIN (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS RHS ON (LHS.region_id = RHS.n)) ORDER BY region_name;

/*
Gold Result:
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Banana',)
*/