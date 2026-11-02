-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'R1', 'Zebra');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (2, 'R2', 'Alpha');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "region_name" FROM "region" WHERE ("region_name" <> 'Denmark') ORDER BY region_name, region.region_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT region_name FROM region WHERE region_name <> 'Denmark';

/*
Prediction Result:
('Zebra',)
('Alpha',)
*/