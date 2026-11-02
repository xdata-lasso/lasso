-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocB', 'Boston', 'US', 'O3', 10.5, '2023-01-01', 'ppm', 'EPA', 42.3, -71.0, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocA', 'Austin', 'US', 'NO2', 12.0, '2023-01-02', 'ppm', 'EPA', 30.2, -97.7, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocC', 'Chicago', 'US', 'PM2.5', 8.0, '2023-01-03', 'ug/m3', 'EPA', 41.8, -87.6, 24.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocD', 'Toronto', 'CA', 'O3', 9.0, '2023-01-01', 'ppm', 'EnvCan', 43.6, -79.3, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocE', 'Miami', 'us', 'O3', 11.0, '2023-01-01', 'ppm', 'EPA', 25.7, -80.1, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocF', 'Dallas', 'USA', 'O3', 15.0, '2023-01-01', 'ppm', 'EPA', 32.7, -96.7, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocG', 'Seattle', NULL, 'O3', 5.0, '2023-01-01', 'ppm', 'EPA', 47.6, -122.3, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocH', 'US', 'UK', 'O3', 7.0, '2023-01-01', 'ppm', 'DEFRA', 51.5, -0.1, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city", "country" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin', 'US')
('Boston', 'US')
('Chicago', 'US')
*/

-- Prediction Query
SELECT city, country FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Boston', 'US')
('Austin', 'US')
('Chicago', 'US')
*/