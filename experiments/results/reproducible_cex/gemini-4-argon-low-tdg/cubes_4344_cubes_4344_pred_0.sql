-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching where LHS.days_held = RHS.reign across different rows for the same wrestler,
-- vs. same row matching, vs. no match, and tests ORDER BY name.
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'Zack', '5', '10', 'NY', 'E1');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'Zack', '10', '20', 'LA', 'E2');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'Adam', '15', '15', 'TX', 'E3');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (4, 'Bob', '1', '30', 'FL', 'E4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.days_held AS days_held, RHS.wrestler_id AS wrestler_id, RHS.days_held AS days_held_other, RHS.location AS LOCATION, RHS.event AS event FROM (SELECT name, MIN(days_held) AS days_held FROM wrestler GROUP BY name) AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign)) ORDER BY name;

/*
Gold Result:
('Adam',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zack',)
*/