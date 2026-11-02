-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('365 Lin Trail
Michaelhaven, MO 89566', 'Sheilaville', 'Tunisia', 'board', 1065.5, 'every', 'ppm', 'Stacey Russell', 1066.5, 1067.5, 1068.5);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('78680 Charles Spurs Apt. 805
South David, ME 48296', 'West Jasonbury', 'Papua New Guinea', 'understand', 1066.5, 'health', 'ppm', 'Victoria Johnson', 1067.5, 1068.5, 1069.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, global_air_quality_2.location NULLS LAST, global_air_quality_2.city NULLS LAST, global_air_quality_2.pollutant NULLS LAST, global_air_quality_2.value NULLS LAST, global_air_quality_2.timestamp NULLS LAST, global_air_quality_2.unit NULLS LAST, global_air_quality_2.source_name NULLS LAST, global_air_quality_2.latitude NULLS LAST, global_air_quality_2.longitude NULLS LAST, global_air_quality_2.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('Papua New Guinea',)
('Tunisia',)
*/

-- Prediction Query
SELECT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('Tunisia',)
('Papua New Guinea',)
*/