-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO buildings (id, name, city, height, stories, status) VALUES (1, 'default2', NULL, NULL, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT stories FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.city AS city, LHS.height AS height, LHS.stories AS stories, LHS.status AS status, LHS.maxheight AS maxheight, RHS.id AS id_other, RHS.name AS name_other, RHS.city AS city_other, RHS.status AS status_other, RHS.maxheight AS maxheight_other FROM (SELECT id, name, city, height, stories, status, MAX(height) OVER () AS maxheight FROM buildings) AS LHS INNER JOIN (SELECT id, name, city, height, stories, status, MAX(height) OVER () AS maxheight FROM buildings) AS RHS ON (LHS.stories = RHS.stories AND LHS.maxheight = RHS.height)) ORDER BY stories;

/*
Gold Result:
*/

-- Prediction Query
SELECT Stories FROM buildings ORDER BY Height DESC, buildings.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/