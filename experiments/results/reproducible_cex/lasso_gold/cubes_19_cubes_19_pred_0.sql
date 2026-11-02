-- Schema DDL
CREATE TABLE "global_air_quality" ("location" TEXT, "city" TEXT, "country" TEXT, "pollutant" TEXT, "value" REAL, "timestamp" TEXT, "unit" TEXT, "source_name" TEXT, "latitude" REAL, "longitude" REAL, "averaged_over_in_hours" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('1458 Frazier Ville Suite 014
New Sydney, KS 05515', 'West Jasonbury', 'US', 'pick', 1065.5, 'board', 'hair', 'Emily Obrien', 1066.5, 1067.5, 1068.5);
INSERT INTO "global_air_quality" ("location", "city", "country", "pollutant", "value", "timestamp", "unit", "source_name", "latitude", "longitude", "averaged_over_in_hours") VALUES ('78680 Charles Spurs Apt. 805
South David, ME 48296', 'East Andrew', 'US', 'reflect', 1066.5, 'leader', 'health', 'Stacey Russell', 1067.5, 1068.5, 1069.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city" FROM "global_air_quality" WHERE ("country" = 'US') ORDER BY city, global_air_quality.location NULLS LAST, global_air_quality.country NULLS LAST, global_air_quality.pollutant NULLS LAST, global_air_quality.value NULLS LAST, global_air_quality.timestamp NULLS LAST, global_air_quality.unit NULLS LAST, global_air_quality.source_name NULLS LAST, global_air_quality.latitude NULLS LAST, global_air_quality.longitude NULLS LAST, global_air_quality.averaged_over_in_hours NULLS LAST;

/*
Gold Result:
('East Andrew',)
('West Jasonbury',)
*/

-- Prediction Query
SELECT city FROM global_air_quality WHERE country = 'US';

/*
Prediction Result:
('West Jasonbury',)
('East Andrew',)
*/