-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: buildings --
INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (1, '5k5swwqcgs', '9n8', 1610062532, 1, 'pgu7vfe4');

INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (2, 'hria2ypuzhs', 'rwbbp6luhvd', -1377057208, 1, 'ilbnp');

INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (3, 'mdpos', 'ie5', -1209887326, 1, 'klfa9000t');

INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (-2147483645, 'c4ecigce', '76nium52', 0, 1, 'zbuo4nrqrof');

INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (-2147483644, 'qyp5s5bbp0', '2eutliqa11r', 0, 1, 'ytoo3o9');

INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (-2147483643, 'l7', 'klex14ji', -1, 1, '7zwau2dwyr');

INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (4, '5k5swwqcgs', '9n8', 1610062532, NULL, 'pgu7vfe4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT stories FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.city AS city, LHS.height AS height, LHS.stories AS stories, LHS.status AS status, LHS.maxheight AS maxheight, RHS.id AS id_other, RHS.name AS name_other, RHS.city AS city_other, RHS.status AS status_other, RHS.maxheight AS maxheight_other FROM (SELECT id, name, city, height, stories, status, MAX(height) OVER () AS maxheight FROM buildings) AS LHS INNER JOIN (SELECT id, name, city, height, stories, status, MAX(height) OVER () AS maxheight FROM buildings) AS RHS ON (LHS.stories = RHS.stories AND LHS.maxheight = RHS.height)) ORDER BY stories;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT Stories FROM buildings ORDER BY Height DESC, buildings.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/