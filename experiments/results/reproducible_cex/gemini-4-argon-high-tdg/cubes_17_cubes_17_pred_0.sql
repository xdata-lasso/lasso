-- Schema DDL
CREATE TABLE "global_air_quality_3" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO global_air_quality_3 (location, city, country, pollutant, value, timestamp, unit, source_name, latitude, longitude, averaged_over_in_hours) VALUES ('Loc_Unique', 'City_Unique', 'Country_Unique', 'Pollutant_Unique', 0.0, '2023-05-10 12:30:00', 'Unit_Unique', 'Source_Unique', 12.34, 56.78, 24.0);
INSERT INTO global_air_quality_3 (location, city, country, pollutant, value, timestamp, unit, source_name, latitude, longitude, averaged_over_in_hours) VALUES ('Loc_Dup', 'City_Dup', 'Country_Dup', 'o3', 0.0, '2023-06-01 08:00:00', 'ppm', 'AirNow', 45.0, -90.0, 8.0);
INSERT INTO global_air_quality_3 (location, city, country, pollutant, value, timestamp, unit, source_name, latitude, longitude, averaged_over_in_hours) VALUES ('Loc_Dup', 'City_Dup', 'Country_Dup', 'o3', 0.0, '2023-06-01 08:00:00', 'ppm', 'AirNow', 45.0, -90.0, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, city, country, pollutant, value, TIMESTAMP, unit, source_name, latitude, longitude, averaged_over_in_hours FROM global_air_quality_3 WHERE (value = 0.0) ORDER BY LOCATION, global_air_quality_3.city NULLS LAST, global_air_quality_3.country NULLS LAST, global_air_quality_3.pollutant NULLS LAST, global_air_quality_3.value NULLS LAST, global_air_quality_3.timestamp NULLS LAST, global_air_quality_3.unit NULLS LAST, global_air_quality_3.source_name NULLS LAST, global_air_quality_3.latitude NULLS LAST, global_air_quality_3.longitude NULLS LAST, global_air_quality_3.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Loc_Dup', 'City_Dup', 'Country_Dup', 'o3', 0.0, '2023-06-01 08:00:00', 'ppm', 'AirNow', 45.0, -90.0, 8.0)
('Loc_Dup', 'City_Dup', 'Country_Dup', 'o3', 0.0, '2023-06-01 08:00:00', 'ppm', 'AirNow', 45.0, -90.0, 8.0)
('Loc_Unique', 'City_Unique', 'Country_Unique', 'Pollutant_Unique', 0.0, '2023-05-10 12:30:00', 'Unit_Unique', 'Source_Unique', 12.34, 56.78, 24.0)
*/

-- Prediction Query
SELECT * FROM global_air_quality_3 WHERE value = 0;

/*
Prediction Result:
('Loc_Unique', 'City_Unique', 'Country_Unique', 'Pollutant_Unique', 0.0, '2023-05-10 12:30:00', 'Unit_Unique', 'Source_Unique', 12.34, 56.78, 24.0)
('Loc_Dup', 'City_Dup', 'Country_Dup', 'o3', 0.0, '2023-06-01 08:00:00', 'ppm', 'AirNow', 45.0, -90.0, 8.0)
('Loc_Dup', 'City_Dup', 'Country_Dup', 'o3', 0.0, '2023-06-01 08:00:00', 'ppm', 'AirNow', 45.0, -90.0, 8.0)
*/