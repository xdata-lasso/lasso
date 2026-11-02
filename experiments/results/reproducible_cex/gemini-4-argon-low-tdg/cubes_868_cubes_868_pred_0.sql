-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Alpha', '2021-05', 110, 12.0, 1);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Beta', '2021-06', 130, 20.0, 3);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (3, 'Gamma', '2021-07', 140, 30.0, 4);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (1, 'C1', 'Central');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (2, 'C2', 'Central');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (3, 'W1', 'West');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (4, 'W2', 'West');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (1, 1, 10.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (1, 2, 15.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (2, 3, 20.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (3, 1, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (4, 2, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name, n AS count___ FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, LHS.storm_id AS storm_id, LHS.number_city_affected AS number_city_affected, RHS.n AS n FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id, RHS.number_city_affected AS number_city_affected FROM region AS LHS INNER JOIN affected_region AS RHS ON (LHS.region_id = RHS.region_id)) AS LHS INNER JOIN (SELECT region_id, COUNT(*) AS n FROM affected_region GROUP BY region_id) AS RHS ON (LHS.region_id = RHS.region_id)) ORDER BY region_name, count___ NULLS LAST;

/*
Gold Result:
('Central', 1)
('Central', 2)
('West', 1)
*/

-- Prediction Query
SELECT T1.region_name, COUNT(*) FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id;

/*
Prediction Result:
('Central', 2)
('Central', 1)
('West', 1)
('West', 1)
*/