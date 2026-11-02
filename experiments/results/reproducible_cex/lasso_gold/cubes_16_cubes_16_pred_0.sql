-- Schema DDL
CREATE TABLE "global_air_quality_2" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('5433 Donna Locks
Joshualand, WI 37086', 'Darlenefurt', 'Ethiopia', 'collection', 1065.5, 'not', 'ppm', 'Alexander Wiley', 1066.5, 1067.5, 1068.5);
INSERT INTO "global_air_quality_2" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('8692 Michelle Union
South Angel, WA 44041', 'Phambury', 'Eritrea', 'threat', 1066.5, 'store', 'ppm', 'Janet Williams', 1067.5, 1068.5, 1069.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM "global_air_quality_2" WHERE ("unit" = 'ppm') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('Eritrea',)
('Ethiopia',)
*/

-- Prediction Query
SELECT DISTINCT country FROM global_air_quality_2 WHERE unit = 'ppm';

/*
Prediction Result:
('Ethiopia',)
('Eritrea',)
*/