-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_code, region_name) VALUES (1, NULL, 'default1'), (0, NULL, 'default2'), (2, 'default2', 'default2'), (3, NULL, 'default2'), (4, 'default1', NULL), (5, 'default1', 'default2');
INSERT INTO storm (storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths) VALUES (1, 'default2', 'default1', 1, NULL, 0), (0, 'default2', NULL, 1, 0.0, 1), (2, 'default1', 'default1', 0, 1.0, 0), (3, 'default2', NULL, 1, 1.0, 1), (4, 'default2', 'default2', 0, 1.0, 0), (5, NULL, 'default2', 0, NULL, 0), (6, NULL, 'default1', 1, 1.0, 1);
INSERT INTO affected_region (region_id, storm_id, number_city_affected) VALUES (0, 6, NULL), (1, 2, NULL), (4, 2, 0.0), (3, 2, 0.0), (3, 6, NULL), (4, 1, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.storm_id AS storm_id, LHS.n AS n, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.number_deaths AS number_deaths FROM (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS LHS INNER JOIN storm AS RHS ON (LHS.storm_id = RHS.storm_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
('default1', 3)
('default2', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id = T2.storm_id GROUP BY T1.storm_id;

/*
Prediction Result:
('default2', 1)
('default1', 3)
(None, 2)
*/