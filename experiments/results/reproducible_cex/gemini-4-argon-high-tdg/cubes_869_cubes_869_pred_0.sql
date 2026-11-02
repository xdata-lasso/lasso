-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Zeta', '2020-10-24', 100, 10.5, 5);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Beta', '2020-09-17', 200, 0.0, 0);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (3, 'Alpha', '2020-09-18', 150, 50.0, 10);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (1, 'R1', 'East');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (3, 'R3', 'West');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (1, 2, 0.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (3, 2, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM storm AS LHS WHERE NOT EXISTS(SELECT 1 FROM affected_region AS RHS WHERE (LHS.storm_id = RHS.storm_id))) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM storm WHERE NOT storm_id IN (SELECT storm_id FROM affected_region);

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/