-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO global_air_quality (location, city, country, pollutant, value, timestamp, unit, source_name, latitude, longitude, averaged_over_in_hours) VALUES ('Loc1', 'Chicago', 'US', 'pm25', 10.0, '2020-01-01', 'ug/m3', 'src1', 41.8, -87.6, 1.0);
INSERT INTO global_air_quality (location, city, country, pollutant, value, timestamp, unit, source_name, latitude, longitude, averaged_over_in_hours) VALUES ('Loc2', 'Austin', 'US', 'pm25', 5.0, '2020-01-01', 'ug/m3', 'src2', 30.2, -97.7, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Austin',)
('Chicago',)
*/

-- Prediction Query
SELECT city FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('Chicago',)
('Austin',)
*/