-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (unit = 'ppm', case sensitivity, NULLs, other values), DISTINCT vs ALL, and primary ordering by country (including NULL country).
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocB', 'City1', 'US', 'co', 1.0, '2023-01-01', 'ppm', 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocA', 'City1', 'US', 'co', 1.0, '2023-01-01', 'ppm', 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocC', 'City2', 'CA', 'co', 1.0, '2023-01-01', 'ppm', 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocD', 'City3', 'MX', 'co', 1.0, '2023-01-01', 'ppb', 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocE', 'City4', 'FR', 'co', 1.0, '2023-01-01', 'PPM', 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocF', 'City5', 'DE', 'co', 1.0, '2023-01-01', NULL, 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocG', 'City6', NULL, 'co', 1.0, '2023-01-01', 'ppm', 'Src1', 10.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('LocH', 'City7', 'ppm', 'co', 1.0, '2023-01-01', 'ug/m3', 'Src1', 10.0, 20.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, global_air_quality_2.location NULLS LAST, global_air_quality_2.city NULLS LAST, global_air_quality_2.pollutant NULLS LAST, global_air_quality_2.value NULLS LAST, global_air_quality_2.timestamp NULLS LAST, global_air_quality_2.unit NULLS LAST, global_air_quality_2.source_name NULLS LAST, global_air_quality_2.latitude NULLS LAST, global_air_quality_2.longitude NULLS LAST, global_air_quality_2.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
(None,)
('CA',)
('US',)
('US',)
*/

-- Prediction Query
SELECT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('US',)
('US',)
('CA',)
(None,)
*/