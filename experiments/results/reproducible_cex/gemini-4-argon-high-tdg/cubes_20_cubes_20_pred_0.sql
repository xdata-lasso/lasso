-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_A', 'City_A', 'US', 'O3', 0.05, '2023-01-01 00:00:00', 'ppm', 'Source_A', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_B', 'City_B', 'MX', 'CO', 1.25, '2023-01-02 00:00:00', 'ppm', 'Source_B', 20.0, 30.0, 8.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_C', 'City_C', 'CA', 'NO2', 2.50, '2023-01-03 00:00:00', 'ppm', 'Source_C', 30.0, 40.0, 24.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_D', 'City_D', 'US', 'SO2', 3.75, '2023-01-04 00:00:00', 'ppm', 'Source_D', 40.0, 50.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_E', 'City_E', 'DE', 'PM25', 15.0, '2023-01-05 00:00:00', 'µg/m³', 'Source_E', 50.0, 60.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc_F', 'City_F', 'FR', 'O3', 45.0, '2023-01-06 00:00:00', 'ppb', 'Source_F', 60.0, 70.0, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, global_air_quality_2.location NULLS LAST, global_air_quality_2.city NULLS LAST, global_air_quality_2.pollutant NULLS LAST, global_air_quality_2.value NULLS LAST, global_air_quality_2.timestamp NULLS LAST, global_air_quality_2.unit NULLS LAST, global_air_quality_2.source_name NULLS LAST, global_air_quality_2.latitude NULLS LAST, global_air_quality_2.longitude NULLS LAST, global_air_quality_2.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('CA',)
('MX',)
('US',)
('US',)
*/

-- Prediction Query
SELECT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('US',)
('MX',)
('CA',)
('US',)
*/