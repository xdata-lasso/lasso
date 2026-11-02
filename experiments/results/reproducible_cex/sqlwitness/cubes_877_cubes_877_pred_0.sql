-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_code, region_name) VALUES (1, 'default2', 'default1'), (2, 'default1', 'default1'), (3, 'default1', 'default2');
INSERT INTO storm (storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths) VALUES (0, NULL, 'default1', NULL, 1.0, 2), (1, NULL, NULL, 0, 1.0, NULL), (3, NULL, 'default1', 0, 3.0, 0), (2, NULL, NULL, 1, 1.0, 0), (4, 'default1', 'default1', NULL, NULL, NULL);
INSERT INTO affected_region (region_id, storm_id, number_city_affected) VALUES (2, 0, NULL), (3, 1, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id FROM region AS LHS INNER JOIN (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS RHS ON (LHS.region_id = RHS.n)) ORDER BY region_name;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/