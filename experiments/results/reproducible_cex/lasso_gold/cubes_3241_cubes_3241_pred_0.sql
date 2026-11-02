-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1029, 'Tricia Valencia', 'activity', 'Pitcairn Islands', 1030);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1039, 'Lisa Brandt', 'woman', 'Mauritius', 1040);
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1031, 1029, 'set', 1032, '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 1033, 'claim');
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1036, 1029, 'why', 1037, '0154 Brian Wells Apt. 171
East Donna, OH 22144', 1038, 'evidence');
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1041, 1039, 'someone', 1042, '465 Lam Mission
East Jeffreymouth, AK 77611', 1043, 'once');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, fate, name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) ORDER BY code, fate NULLS LAST, name NULLS LAST;

/*
Gold Result:
('set', 'claim', 'Tricia Valencia')
('someone', 'once', 'Lisa Brandt')
('why', 'evidence', 'Tricia Valencia')
*/

-- Prediction Query
SELECT T1.Code, T1.Fate, T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID;

/*
Prediction Result:
('set', 'claim', 'Tricia Valencia')
('why', 'evidence', 'Tricia Valencia')
('someone', 'once', 'Lisa Brandt')
*/