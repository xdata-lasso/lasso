-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty child table (affected_region is empty) and NULL region_name handling.
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (10, 'C_WEST', 'West Coast');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (20, 'C_EAST', 'East Coast');
INSERT INTO region (Region_id, Region_code, Region_name) VALUES (30, 'C_NULL', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT * FROM region AS LHS WHERE NOT EXISTS(SELECT 1 FROM affected_region AS RHS WHERE (LHS.region_id = RHS.region_id))) ORDER BY region_name;

/*
Gold Result:
(None,)
('East Coast',)
('West Coast',)
*/

-- Prediction Query
SELECT region_name FROM region WHERE NOT region_id IN (SELECT region_id FROM affected_region);

/*
Prediction Result:
('West Coast',)
('East Coast',)
(None,)
*/