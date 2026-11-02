-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality_2" ("country", "unit") VALUES ('B', 'ppm');
INSERT INTO "global_air_quality_2" ("country", "unit") VALUES ('A', 'ppm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, global_air_quality_2.location NULLS LAST, global_air_quality_2.city NULLS LAST, global_air_quality_2.pollutant NULLS LAST, global_air_quality_2.value NULLS LAST, global_air_quality_2.timestamp NULLS LAST, global_air_quality_2.unit NULLS LAST, global_air_quality_2.source_name NULLS LAST, global_air_quality_2.latitude NULLS LAST, global_air_quality_2.longitude NULLS LAST, global_air_quality_2.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('B',)
('A',)
*/