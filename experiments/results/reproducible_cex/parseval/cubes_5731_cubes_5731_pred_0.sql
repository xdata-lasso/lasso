-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1, 'shi_8114e5', '5k5swwqcgs', '9n8', 1610062532);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (3, 'shi_8114e5', 'pgu7vfe4', 'hria2ypuzhs', 700293388);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (0, 'shi_8114e5', 'wbbp6luhvdlt', 'ilbnp', 1);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-1, 'shi_8114e5', 'mdpos', 'ie5', 1);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (2, NULL, '5k5swwqcgs', '9n8', 1610062532);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.nationality AS nationality, LHS.tonnage AS tonnage, LHS.maxtonnage AS maxtonnage, RHS.ship_id AS ship_id_other, RHS.name AS name_other, RHS.type AS type_other, RHS.nationality AS nationality_other, RHS.tonnage AS tonnage_other, RHS.maxtonnage AS maxtonnage_other FROM (SELECT ship_id, name, TYPE, nationality, tonnage, MAX(tonnage) OVER () AS maxtonnage FROM ship) AS LHS CROSS JOIN (SELECT ship_id, name, TYPE, nationality, tonnage, MAX(tonnage) OVER () AS maxtonnage FROM ship) AS RHS) WHERE (tonnage = maxtonnage_other AND tonnage_other >= maxtonnage_other) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('shi_8114e5',)
('shi_8114e5',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage DESC, ship.ship_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('shi_8114e5',)
*/