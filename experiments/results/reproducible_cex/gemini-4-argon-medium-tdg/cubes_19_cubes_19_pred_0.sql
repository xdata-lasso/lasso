-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc1', 'Boston', 'US', 'pm25', 10.5, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 42.36, -71.05, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc2', 'Boston', 'US', 'pm10', 20.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 42.36, -71.05, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc3', 'Austin', 'US', 'o3', 0.05, '2023-01-01T00:00:00Z', 'ppm', 'EPA', 30.26, -97.74, 8.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc4', 'Toronto', 'CA', 'pm25', 8.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EnvCan', 43.65, -79.38, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc5', 'London', 'GB', 'no2', 15.0, '2023-01-01T00:00:00Z', 'µg/m³', 'DEFRA', 51.50, -0.12, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin',)
('Boston',)
('Boston',)
*/

-- Prediction Query
SELECT city FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Boston',)
('Boston',)
('Austin',)
*/