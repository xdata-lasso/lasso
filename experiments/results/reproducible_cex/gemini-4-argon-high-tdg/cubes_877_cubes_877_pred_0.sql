-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (100, 'Storm Alpha', '2020-05-01', 120, 15.5, 2);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (200, 'Storm Beta', '2020-06-10', 150, 40.0, 5);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (300, 'Storm Calm', '2020-07-01', 80, 0.0, 0);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (1, 'RC_M', 'Omega');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (2, 'RC_A', 'Gamma');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (3, 'RC_Z', 'Alpha');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (5, 'RC_B', 'Delta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (10, 'RC_C', 'RegionTen');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (20, 'RC_D', 'RegionTwenty');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (30, 'RC_E', 'RegionThirty');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (100, 'RC_F', 'StormHundredRegion');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 100, 3.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 100, 4.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 200, 2.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 200, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (30, 200, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id FROM region AS LHS INNER JOIN (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS RHS ON (LHS.region_id = RHS.n)) ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Gamma',)
*/

-- Prediction Query
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('RegionTen',)
('RegionTwenty',)
*/