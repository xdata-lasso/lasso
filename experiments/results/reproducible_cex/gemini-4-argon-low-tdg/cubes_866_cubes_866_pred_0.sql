-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive dataset testing boundary conditions (0, 1, >1), negative values, NULLs, duplicates, and join fan-outs/orphans
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (10, 'R1', 'North');
INSERT INTO "region" ("Region_id", "Region_code", "Region_name") VALUES (20, 'R2', 'South');
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (1, 'Alpha', 'Jan 1', 100, 10.5, 0);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (2, 'Beta', 'Feb 2', 120, 0.0, 1);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (3, 'Beta', 'Mar 3', 130, 50.0, 5);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (4, 'Delta', 'Apr 4', 0, 20.0, 5);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (5, 'Epsilon', 'May 5', 140, NULL, -2);
INSERT INTO "storm" ("Storm_ID", "Name", "Dates_active", "Max_speed", "Damage_millions_USD", "Number_Deaths") VALUES (6, 'Zeta', 'Jun 6', NULL, 5.0, NULL);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 1, 3.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (10, 2, 0.0);
INSERT INTO "affected_region" ("Region_id", "Storm_ID", "Number_city_affected") VALUES (20, 2, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM storm WHERE (number_deaths <> 0))) ORDER BY count___;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM storm WHERE Number_Deaths > 0;

/*
Prediction Result:
(3,)
*/