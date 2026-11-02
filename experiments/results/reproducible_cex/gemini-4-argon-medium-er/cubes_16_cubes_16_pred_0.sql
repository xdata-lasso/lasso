-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality_2" ("country", "unit") VALUES ('USA', 'ppm');
INSERT INTO "global_air_quality_2" ("country", "unit") VALUES ('Canada', 'ppm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT DISTINCT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('USA',)
('Canada',)
*/