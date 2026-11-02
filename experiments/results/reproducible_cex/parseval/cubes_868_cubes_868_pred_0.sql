-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: storm --
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1, '5k5swwqcgs', '9n8', 1610062532, 475.173408, 1871297066);

-- Inserting into table: region --
INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (1, 'lhs_266341', 'lhs_0af572');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (2, 'lhs_266341', 'lhs_0af572');

INSERT INTO "region" ("region_id", "region_code", "region_name") VALUES (3, 'e4', 'hria2ypuzhs');

-- Inserting into table: affected_region --
INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (1, 1, 688.4027);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (2, 1, 520.784135);

INSERT INTO "affected_region" ("region_id", "storm_id", "number_city_affected") VALUES (3, 1, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name, n AS count___ FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, LHS.storm_id AS storm_id, LHS.number_city_affected AS number_city_affected, RHS.n AS n FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id, RHS.number_city_affected AS number_city_affected FROM region AS LHS INNER JOIN affected_region AS RHS ON (LHS.region_id = RHS.region_id)) AS LHS INNER JOIN (SELECT region_id, COUNT(*) AS n FROM affected_region GROUP BY region_id) AS RHS ON (LHS.region_id = RHS.region_id)) ORDER BY region_name, count___ NULLS LAST;

/*
Gold Result:
('hria2ypuzhs', 1)
('lhs_0af572', 1)
*/

-- Prediction Query
SELECT T1.region_name, COUNT(*) FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id;

/*
Prediction Result:
('lhs_0af572', 1)
('lhs_0af572', 1)
('hria2ypuzhs', 1)
*/