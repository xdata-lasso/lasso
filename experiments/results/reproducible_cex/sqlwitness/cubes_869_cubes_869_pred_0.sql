-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_code, region_name) VALUES (1, NULL, NULL), (2, 'default1', 'default1'), (0, 'default2', NULL), (3, 'default1', 'default2');
INSERT INTO storm (storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths) VALUES (1, 'default2', 'default1', 0, NULL, NULL), (0, NULL, 'default2', 2, 2.0, 2), (2, 'default1', 'default2', 1, 2.0, NULL), (3, NULL, 'default1', 1, 1.0, NULL), (4, 'default1', 'default2', 2, NULL, 1), (5, 'default2', 'default2', 1, NULL, NULL), (6, 'default1', NULL, 0, 1.0, 1);
INSERT INTO affected_region (region_id, storm_id, number_city_affected) VALUES (2, 3, 2.0), (2, 1, 1.0), (1, 4, NULL), (2, 2, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM storm AS LHS WHERE NOT EXISTS(SELECT 1 FROM affected_region AS RHS WHERE (LHS.storm_id = RHS.storm_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM storm WHERE NOT storm_id IN (SELECT storm_id FROM affected_region);

/*
Prediction Result:
(None,)
('default2',)
('default1',)
*/