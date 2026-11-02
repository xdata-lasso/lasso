-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (30, 'Alpha', '2020-06-01', 120, 50.5, 5);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (10, 'Zeta', '2020-11-01', 150, 10.2, 20);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (20, 'Alpha', '2021-06-01', 110, 90.0, 2);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (40, 'Beta', '2021-07-01', 80, 30.75, 12);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (1, 'NA', 'North America');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (2, 'CA', 'Central America');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (1, 10, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (2, 10, 3.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (1, 20, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, damage_millions_usd FROM storm ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
('Alpha', 90.0)
('Alpha', 50.5)
('Beta', 30.75)
('Zeta', 10.2)
*/

-- Prediction Query
SELECT name, damage_millions_USD FROM storm ORDER BY max_speed DESC, storm.storm_id NULLS LAST;

/*
Prediction Result:
('Zeta', 10.2)
('Alpha', 50.5)
('Alpha', 90.0)
('Beta', 30.75)
*/