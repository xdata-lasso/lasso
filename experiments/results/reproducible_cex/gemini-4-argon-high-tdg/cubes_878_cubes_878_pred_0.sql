-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Hurricane Alpha', '2020-08-01', 120, 50.5, 5);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Tropical Storm Beta', '2020-09-15', 70, 12.0, 0);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (1, 'R_B', 'Gamma');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (2, 'R_C', 'Alpha');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (3, 'R_A', 'Beta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (4, 'R_D', 'Delta');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (5, 'R_E', 'Epsilon');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (4, 1, 3.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (5, 1, 2.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (5, 2, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT * FROM region AS LHS WHERE NOT EXISTS(SELECT 1 FROM affected_region AS RHS WHERE (LHS.region_id = RHS.region_id))) ORDER BY region_name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT region_name FROM region WHERE NOT region_id IN (SELECT region_id FROM affected_region);

/*
Prediction Result:
('Gamma',)
('Alpha',)
('Beta',)
*/