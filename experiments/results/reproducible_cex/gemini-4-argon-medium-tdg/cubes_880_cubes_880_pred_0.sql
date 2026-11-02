-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for WHERE (number_deaths > 1), including NULL, negative, 0, 1, 2, and larger values.
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'Alpha', 'Jan 1-5', 100, 10.5, -5);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (2, 'Beta', 'Feb 2-6', 110, 20.0, 0);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (3, 'Gamma', 'Mar 3-7', 120, 30.2, 1);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (4, 'Delta', 'Apr 4-8', 130, 40.8, 2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (5, 'Epsilon', 'May 5-9', 140, 50.1, 100);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (6, 'Zeta', 'Jun 6-10', 150, 60.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, dates_active, number_deaths FROM storm WHERE (number_deaths > 1) ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
('Delta', 'Apr 4-8', 2)
('Epsilon', 'May 5-9', 100)
*/

-- Prediction Query
SELECT name, dates_active, number_deaths FROM storm WHERE number_deaths >= 1;

/*
Prediction Result:
('Gamma', 'Mar 3-7', 1)
('Delta', 'Apr 4-8', 2)
('Epsilon', 'May 5-9', 100)
*/