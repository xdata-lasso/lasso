-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('US' vs non-'US', case sensitivity, substring, NULLs) and basic city ordering
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc1', 'Seattle', 'US', 'pm25', 10.5, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 47.6062, -122.3321, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc2', 'Austin', 'US', 'pm10', 20.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 30.2672, -97.7431, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc3', 'Toronto', 'CA', 'pm25', 8.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EnvCan', 43.6532, -79.3832, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc4', 'Miami', 'us', 'pm25', 12.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 25.7617, -80.1918, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc5', 'Dallas', 'USA', 'pm25', 15.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 32.7767, -96.7970, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc6', 'Denver', ' US ', 'pm25', 9.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 39.7392, -104.9903, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc7', 'Phoenix', NULL, 'pm25', 25.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 33.4484, -112.0740, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin',)
('Seattle',)
*/

-- Prediction Query
SELECT city FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Seattle',)
('Austin',)
*/