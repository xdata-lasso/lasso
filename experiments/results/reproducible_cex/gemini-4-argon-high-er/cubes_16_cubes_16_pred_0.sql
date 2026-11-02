-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc1', 'New York', 'US', 'CO', 1.0, '2023-01-01', 'ppm', 'Source1', 40.71, -74.00, 1.0);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('Loc2', 'Toronto', 'CA', 'CO', 2.0, '2023-01-01', 'ppm', 'Source2', 43.65, -79.38, 1.0);
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