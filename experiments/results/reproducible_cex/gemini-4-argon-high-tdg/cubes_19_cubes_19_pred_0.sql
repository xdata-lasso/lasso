-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station A', 'Seattle', 'US', 'pm25', 8.5, '2023-01-01T00:00:00Z', 'µg/m³', 'EPA', 47.6062, -122.3321, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station B', 'London', 'UK', 'pm10', 15.2, '2023-01-01T00:00:00Z', 'µg/m³', 'DEFRA', 51.5074, -0.1278, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station C', 'Austin', 'US', 'o3', 0.04, '2023-01-02T00:00:00Z', 'ppm', 'TCEQ', 30.2672, -97.7431, 8.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station D', 'Austin', 'US', 'no2', 12.1, '2023-01-03T00:00:00Z', 'ppb', 'TCEQ', 30.2700, -97.7400, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin',)
('Austin',)
('Seattle',)
*/

-- Prediction Query
SELECT city FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Seattle',)
('Austin',)
('Austin',)
*/