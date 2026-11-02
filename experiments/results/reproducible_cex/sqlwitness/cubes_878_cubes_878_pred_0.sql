-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (region_id, region_code, region_name) VALUES (0, 'default2', NULL), (2, NULL, 'default1'), (1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT * FROM region AS LHS WHERE NOT EXISTS(SELECT 1 FROM affected_region AS RHS WHERE (LHS.region_id = RHS.region_id))) ORDER BY region_name;

/*
Gold Result:
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT region_name FROM region WHERE NOT region_id IN (SELECT region_id FROM affected_region);

/*
Prediction Result:
(None,)
(None,)
('default1',)
*/