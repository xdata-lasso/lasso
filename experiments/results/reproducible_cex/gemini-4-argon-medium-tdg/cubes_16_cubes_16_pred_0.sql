-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc1', 'CityZ', 'US', 'O3', 0.05, '2023-01-01', 'ppm', 'SourceA', 34.0, -118.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc2', 'CityA', 'US', 'CO', 1.2, '2023-01-02', 'ppm', 'SourceB', 40.7, -74.0, 8.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc3', 'CityM', 'CA', 'SO2', 0.01, '2023-01-03', 'ppm', 'SourceC', 45.4, -75.6, 24.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc4', 'CityB', 'BR', 'NO2', 15.0, '2023-01-04', 'ug/m3', 'SourceD', -23.5, -46.6, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc5', 'CityX', 'FR', 'PM2.5', 10.0, '2023-01-05', 'PPM', 'SourceE', 48.8, 2.3, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc6', 'CityY', 'DE', 'PM10', 20.0, '2023-01-06', NULL, 'SourceF', 52.5, 13.4, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('CA',)
('US',)
*/

-- Prediction Query
SELECT DISTINCT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('US',)
('CA',)
*/