-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Storm_Ten', 'Jan 1-5', 100, 50.5, 10);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Storm_Eleven', 'Feb 2-6', 5, 2.5, 11);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (3, 'Storm_TwentyFive', 'Mar 3-9', 8, 1.0, 25);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (4, 'Storm_Nine', 'Apr 1-2', 120, 80.0, 9);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (1, 'R_Z', 'Zeta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (2, 'R_A', 'Alpha');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (3, 'R_B', 'Beta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (4, 'R_G', 'Gamma');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (3, 1, 20.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (2, 2, 3.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (2, 3, 4.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (1, 3, 2.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (3, 4, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.number_city_affected AS number_city_affected FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, RHS.region_id AS region_id, RHS.region_code AS region_code, RHS.region_name AS region_name FROM storm AS LHS CROSS JOIN region AS RHS) AS LHS INNER JOIN affected_region AS RHS ON (LHS.storm_id = RHS.storm_id AND LHS.region_id = RHS.region_id)) WHERE (number_deaths > 10) ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id WHERE T3.number_deaths >= 10;

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
('Beta',)
*/