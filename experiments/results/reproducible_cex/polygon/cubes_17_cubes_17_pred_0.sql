-- Schema DDL
CREATE TABLE "global_air_quality_3" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality_3" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('-563', '-563', '-563', '-563', -563, '-563', '-563', '-563', -563, -563, -563);
INSERT INTO "global_air_quality_3" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('-563', '-563', '-563', '-563', -463, '-563', '-563', '-563', -563, -563, -563);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, city, country, pollutant, value, TIMESTAMP, unit, source_name, latitude, longitude, averaged_over_in_hours FROM global_air_quality_3 WHERE (value = 0.0) ORDER BY LOCATION, global_air_quality_3.city NULLS LAST, global_air_quality_3.country NULLS LAST, global_air_quality_3.pollutant NULLS LAST, global_air_quality_3.value NULLS LAST, global_air_quality_3.timestamp NULLS LAST, global_air_quality_3.unit NULLS LAST, global_air_quality_3.source_name NULLS LAST, global_air_quality_3.latitude NULLS LAST, global_air_quality_3.longitude NULLS LAST, global_air_quality_3.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM global_air_quality_3 WHERE value = 0;

/*
Prediction Result:
*/