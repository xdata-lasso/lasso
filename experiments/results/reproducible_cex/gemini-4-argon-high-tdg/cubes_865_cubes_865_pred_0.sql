-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Charlie', '2021-08-01 to 2021-08-05', 120, 15.5, 2);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Alpha', '2021-06-10 to 2021-06-14', 95, 5.0, 0);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (3, 'Bravo', '2021-07-01 to 2021-07-03', 80, 1.2, 0);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (4, 'Delta', '2021-09-10 to 2021-09-12', 140, 50.0, 10);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (10, 'NA-E', 'North America East');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (20, 'NA-S', 'North America South');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (30, 'CAR', 'Caribbean');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (40, 'EUR-W', 'Western Europe');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 1, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 1, 8.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 2, 3.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 2, 4.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (30, 2, 12.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 4, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.storm_id AS storm_id, LHS.n AS n, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.number_deaths AS number_deaths FROM (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS LHS INNER JOIN storm AS RHS ON (LHS.storm_id = RHS.storm_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 3)
('Charlie', 2)
('Delta', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id = T2.storm_id GROUP BY T1.storm_id;

/*
Prediction Result:
('Charlie', 2)
('Alpha', 3)
('Delta', 1)
*/