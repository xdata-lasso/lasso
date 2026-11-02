-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc1', 'City1', 'US', 'co', 1.0, '2023-01-01', 'ppm', 'SourceA', 10.0, 10.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc2', 'City2', 'US', 'o3', 2.0, '2023-01-02', 'ppm', 'SourceB', 20.0, 20.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc1', 'City1', 'US', 'co', 1.0, '2023-01-01', 'ppm', 'SourceA', 10.0, 10.0, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc3', 'City3', 'CA', 'no2', 0.5, '2023-01-03', 'ppm', 'SourceC', 30.0, 30.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, global_air_quality_2.location NULLS LAST, global_air_quality_2.city NULLS LAST, global_air_quality_2.pollutant NULLS LAST, global_air_quality_2.value NULLS LAST, global_air_quality_2.timestamp NULLS LAST, global_air_quality_2.unit NULLS LAST, global_air_quality_2.source_name NULLS LAST, global_air_quality_2.latitude NULLS LAST, global_air_quality_2.longitude NULLS LAST, global_air_quality_2.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('CA',)
('US',)
('US',)
('US',)
*/

-- Prediction Query
SELECT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('US',)
('US',)
('US',)
('CA',)
*/