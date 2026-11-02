-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (0, 'default2', NULL, 'default1', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.days_held AS days_held, RHS.wrestler_id AS wrestler_id, RHS.days_held AS days_held_other, RHS.location AS LOCATION, RHS.event AS event FROM (SELECT name, MIN(days_held) AS days_held FROM wrestler GROUP BY name) AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/