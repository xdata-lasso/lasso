-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1, '5k5swwqcgs', 'shi_f49d36', '9n8', 6001);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (2, '4', 'shi_f49d36', 'gu7v', 6001);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (3, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 4000);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (4, '5k5swwqcgs', '9n8', '4', 6000);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (5, 'gu7v', 'e4', 'hria2ypuzhs', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (6, 'rwbbp6luhvd', 'tti', 'bnp', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM ship WHERE (tonnage > 6000 OR tonnage = 4000) ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('hria2ypuzhs',)
('shi_f49d36',)
('shi_f49d36',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE Tonnage > 6000 INTERSECT SELECT TYPE FROM ship WHERE Tonnage < 4000;

/*
Prediction Result:
*/