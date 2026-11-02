-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'DK', 'Denmark');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (2, 'DK', 'Denmark');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (3, 'DK_L', 'denmark');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (4, 'SE', 'Sweden');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (5, 'NO', 'Norway');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (6, 'SE2', 'Sweden');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (7, 'FI', 'Finland');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (8, 'UNK', NULL);
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (9, 'EMP', '');
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (101, 'Storm Alpha', 'Jan 1 - Jan 5', 120, 15.5, 2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (102, 'Storm Beta', 'Feb 10 - Feb 12', 150, 45.0, 10);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (1, 101, 5.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (4, 101, 3.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (4, 102, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "region_name" FROM "region" WHERE ("region_name" <> 'Denmark') ORDER BY region_name, region.region_id NULLS LAST;

/*
Gold Result:
('',)
('Finland',)
('Norway',)
('Sweden',)
('Sweden',)
('denmark',)
*/

-- Prediction Query
SELECT region_name FROM region WHERE region_name <> 'Denmark';

/*
Prediction Result:
('denmark',)
('Sweden',)
('Norway',)
('Sweden',)
('Finland',)
('',)
*/