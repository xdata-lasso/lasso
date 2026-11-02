-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (10, 'RC_A', 'Zeta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (20, 'RC_C', 'Alpha');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (30, 'RC_B', 'Mu');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (40, 'RC_D', 'Beta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (50, 'RC_E', 'Delta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (60, 'RC_F', 'Epsilon');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (70, 'RC_G', 'Omega');
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (10, 'Storm_Ten', '2020-01', 100, 50.0, 999);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (100, 'Storm_Hundred', '2020-02', 300, 10.0, 10);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (20, 'Storm_Twenty', '2020-03', 200, 30.0, 20);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (30, 'Storm_Thirty', '2020-04', 150, 20.0, 30);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (40, 'Storm_Forty', '2020-05', 120, 40.0, 999);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (50, 'Storm_Fifty', '2020-06', 180, 60.0, 50);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (60, 'Storm_Sixty', '2020-07', 220, 70.0, 60);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (70, 'Storm_Seventy', '2020-08', 250, 80.0, 70);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 10, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 20, 15.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (30, 30, 10.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (40, 40, 8.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (50, 40, 12.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (40, 60, 18.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT LHS.region_id AS region_id, LHS.storm_id AS storm_id, LHS.number_city_affected AS number_city_affected, RHS.storm_id AS storm_id_other, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.region_code AS region_code, RHS.region_name AS region_name FROM affected_region AS LHS INNER JOIN (SELECT storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths, region_code, region_name, number_deaths AS region_id FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, RHS.region_code AS region_code, RHS.region_name AS region_name FROM storm AS LHS INNER JOIN region AS RHS ON (LHS.number_deaths = RHS.region_id))) AS RHS ON (LHS.storm_id = RHS.number_deaths AND LHS.region_id = RHS.region_id)) ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Mu',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id ORDER BY T3.Number_Deaths DESC, T1.region_id NULLS LAST, T1.storm_id NULLS LAST, T2.region_id NULLS LAST, T3.storm_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta',)
*/