-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Storm_ID (ASC vs DESC), and incorrect secondary sorting by Damage_millions_USD.
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (2, 'Alpha', 'June 1-5', 120, 50.5, 2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'Alpha', 'May 1-3', 100, 100.0, 5);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (3, 'Beta', 'July 10-12', 90, 10.25, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, damage_millions_usd FROM storm ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
('Alpha', 100.0)
('Alpha', 50.5)
('Beta', 10.25)
*/

-- Prediction Query
SELECT name, damage_millions_USD FROM storm ORDER BY max_speed DESC, storm.storm_id NULLS LAST;

/*
Prediction Result:
('Alpha', 50.5)
('Alpha', 100.0)
('Beta', 10.25)
*/