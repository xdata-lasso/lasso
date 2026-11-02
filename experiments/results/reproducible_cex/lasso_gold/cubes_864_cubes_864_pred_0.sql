-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1026, 'Edward Fuller', 'bill', 1027, 1028.5, 1029);
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1030, 'Heidi Lee', 'animal', 1031, 1028.5, 1033);
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1034, 'Gabrielle Davis', 'human', 1035, 1029.5, 1037);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, damage_millions_usd FROM storm ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
('Edward Fuller', 1028.5)
('Gabrielle Davis', 1029.5)
('Heidi Lee', 1028.5)
*/

-- Prediction Query
SELECT name, damage_millions_USD FROM storm ORDER BY max_speed DESC, storm.storm_id NULLS LAST;

/*
Prediction Result:
('Gabrielle Davis', 1029.5)
('Heidi Lee', 1028.5)
('Edward Fuller', 1028.5)
*/