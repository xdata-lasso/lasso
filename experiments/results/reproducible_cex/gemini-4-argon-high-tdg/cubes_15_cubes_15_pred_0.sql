-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_A', 'Chicago', 'US', 'pm25', 10.5, '2023-01-01T00:00:00Z', 'µg/m³', 'AirNow', 41.8781, -87.6298, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_Z', 'Austin', 'US', 'o3', 50.0, '2023-01-03T00:00:00Z', 'ppm', 'EPA', 30.2672, -97.7431, 8.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_M', 'Boston', 'US', 'no2', 25.0, '2023-01-02T00:00:00Z', 'ppm', 'AirNow', 42.3601, -71.0589, 24.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_B', 'Austin', 'US', 'pm10', 15.0, '2023-01-01T12:00:00Z', 'µg/m³', 'AirNow', 30.2672, -97.7431, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_C', 'Toronto', 'CA', 'pm25', 8.0, '2023-01-01T00:00:00Z', 'µg/m³', 'EnvCan', 43.6532, -79.3832, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_D', 'Houston', 'us', 'pm25', 12.0, '2023-01-01T00:00:00Z', 'µg/m³', 'AirNow', 29.7604, -95.3698, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_E', 'Phoenix', 'USA', 'pm25', 18.0, '2023-01-01T00:00:00Z', 'µg/m³', 'AirNow', 33.4484, -112.074, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city", "country" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin', 'US')
('Austin', 'US')
('Boston', 'US')
('Chicago', 'US')
*/

-- Prediction Query
SELECT city, country FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Chicago', 'US')
('Austin', 'US')
('Boston', 'US')
('Austin', 'US')
*/