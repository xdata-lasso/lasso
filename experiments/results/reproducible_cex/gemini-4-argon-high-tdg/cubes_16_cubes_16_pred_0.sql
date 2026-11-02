-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station Z', 'Zeta City', 'US', 'CO', 1.2, '2023-05-03 10:00:00', 'ppm', 'Source C', 34.05, -118.24, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station M', 'Meta City', 'US', 'O3', 0.08, '2023-05-02 09:00:00', 'ppm', 'Source B', 40.71, -74.00, 8.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station A', 'Alpha City', 'FR', 'SO2', 0.5, '2023-05-01 08:00:00', 'ppm', 'Source A', 48.85, 2.35, 24.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station B', 'Beta City', 'BR', 'NO2', 99.9, '2023-05-04 12:00:00', 'ppm', 'Source D', -23.55, -46.63, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station C', 'Gamma City', 'DE', 'PM2.5', 15.0, '2023-05-01 07:00:00', 'µg/m³', 'Source E', 52.52, 13.40, 24.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Station D', 'Delta City', 'IT', 'PM10', 22.0, '2023-05-01 06:00:00', NULL, 'Source F', 41.90, 12.49, 24.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('BR',)
('FR',)
('US',)
*/

-- Prediction Query
SELECT DISTINCT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('US',)
('FR',)
('BR',)
*/