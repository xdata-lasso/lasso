-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT JOIN (unmatched storm), GROUP BY storm_id vs GROUP BY name (duplicate storm names with different Storm_IDs and counts), and tie-breaking ORDER BY count___.
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Alpha', 'Jan 1 - Jan 5', 120, 10.5, 2);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (2, 'Alpha', 'Feb 1 - Feb 3', 90, 5.0, 0);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (3, 'Beta', 'Mar 10 - Mar 12', 150, 50.2, 10);
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (4, 'Gamma', 'Apr 1 - Apr 2', 80, 1.0, 0);
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (10, 'R1', 'North');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (20, 'R2', 'South');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (30, 'R3', 'East');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (40, 'R4', 'West');
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 1, 5.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 1, 3.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (30, 1, 2.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (10, 2, 4.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (20, 3, 10.0);
INSERT INTO affected_region (Region_id, Storm_ID, Number_city_affected) VALUES (30, 3, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.storm_id AS storm_id, LHS.n AS n, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.number_deaths AS number_deaths FROM (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS LHS INNER JOIN storm AS RHS ON (LHS.storm_id = RHS.storm_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 3)
('Beta', 2)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id = T2.storm_id GROUP BY T1.storm_id;

/*
Prediction Result:
('Alpha', 3)
('Alpha', 1)
('Beta', 2)
*/