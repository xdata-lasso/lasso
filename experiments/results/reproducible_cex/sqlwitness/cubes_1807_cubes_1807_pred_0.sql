-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (101, 'default2', 'default2', NULL, 'default1', 'default2'), (99, NULL, NULL, 'default2', NULL, 'default1'), (100, 'default2', NULL, 'default2', 'default2', 'default1'), (0, 'default1', 'default1', NULL, 'default1', NULL), (1, 'default2', 'default1', 'default1', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.wrestler_id AS wrestler_id, LHS.name AS name, LHS.reign AS reign, LHS.days_held AS days_held, LHS.location AS LOCATION, LHS.event AS event, RHS.wrestler_id AS wrestler_id_other, RHS.name AS name_other, RHS.reign AS reign_other, RHS.location AS location_other, RHS.event AS event_other FROM wrestler AS LHS INNER JOIN wrestler AS RHS ON (LHS.reign = RHS.days_held)) ORDER BY name;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT Name FROM wrestler WHERE Days_held < 100;

/*
Prediction Result:
*/