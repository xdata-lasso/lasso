-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Zeta', '2020-10-24', 110, 50.5, 2);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Alpha', '2020-09-18', 1, 0.5, 5);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (3, 'Beta', '2020-09-17', 200, 150.0, 1);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (4, 'Gamma', '2020-10-02', 180, 99.9, 0);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (5, 'Delta', '2020-10-05', 220, 300.0, -3);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (6, 'Epsilon', '2020-10-19', 140, 25.0, NULL);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (10, 'US-FL', 'Florida');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (20, 'US-LA', 'Louisiana');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 1, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 1, 8.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 3, 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, dates_active, number_deaths FROM storm WHERE (number_deaths > 1) ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
('Alpha', '2020-09-18', 5)
('Zeta', '2020-10-24', 2)
*/

-- Prediction Query
SELECT name, dates_active, number_deaths FROM storm WHERE number_deaths >= 1;

/*
Prediction Result:
('Zeta', '2020-10-24', 2)
('Alpha', '2020-09-18', 5)
('Beta', '2020-09-17', 1)
*/