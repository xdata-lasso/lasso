-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocA', 'Seattle', 'US', 'pm25', 12.0, '2023-01-01', 'ug/m3', 'Src1', 47.6, -122.3, 1.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocB', 'Austin', 'US', 'pm10', 25.0, '2023-01-02', 'ug/m3', 'Src2', 30.2, -97.7, 24.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocC', 'Austin', 'US', 'o3', 30.0, '2023-01-03', 'ppm', 'Src1', 30.2, -97.7, 8.0);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocD', 'Denver', 'US', 'co', 1.2, '2023-01-01', 'ppm', 'Src3', 39.7, -104.9, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city", "country" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin', 'US')
('Austin', 'US')
('Denver', 'US')
('Seattle', 'US')
*/

-- Prediction Query
SELECT city, country FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Seattle', 'US')
('Austin', 'US')
('Austin', 'US')
('Denver', 'US')
*/