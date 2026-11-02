-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'Zulu', 'May 1-5', 100, 10.5, 0);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (2, 'Alpha', 'June 10-12', 120, 50.0, 2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (3, 'Alpha', 'July 1-3', 80, 0.0, 0);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (4, 'Beta', 'Aug 5-9', 150, 200.0, 10);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (5, 'Gamma', 'Sept 1-2', 90, 5.0, 1);
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (1, 'R1', 'Alpha');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (2, 'R2', 'North');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (4, 'R4', 'South');
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (1, 4, 0.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (2, 4, 5.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (4, 5, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM storm AS LHS WHERE NOT EXISTS(SELECT 1 FROM affected_region AS RHS WHERE (LHS.storm_id = RHS.storm_id))) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT name FROM storm WHERE NOT storm_id IN (SELECT storm_id FROM affected_region);

/*
Prediction Result:
('Zulu',)
('Alpha',)
('Alpha',)
*/