-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1009, 'Lance Hoffman', 'sense', 1010, 1011.5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, dates_active, number_deaths FROM storm WHERE (number_deaths > 1) ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name, dates_active, number_deaths FROM storm WHERE number_deaths >= 1;

/*
Prediction Result:
('Lance Hoffman', 'sense', 1)
*/