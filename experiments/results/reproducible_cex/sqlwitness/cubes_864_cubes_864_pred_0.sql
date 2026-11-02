-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO storm (storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths) VALUES (1, 'default2', NULL, 0, 0.0, NULL), (0, NULL, NULL, NULL, 0.0, NULL), (2, NULL, 'default2', 0, 0.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, damage_millions_usd FROM storm ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
(None, 0.0)
(None, 0.0)
('default2', 0.0)
*/

-- Prediction Query
SELECT name, damage_millions_USD FROM storm ORDER BY max_speed DESC, storm.storm_id NULLS LAST;

/*
Prediction Result:
('default2', 0.0)
(None, 0.0)
(None, 0.0)
*/