-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests asymmetric join condition (LHS.days_held = RHS.reign) vs symmetric (reign = reign or days_held = days_held),
-- projection of LHS.days_held vs LHS.reign vs RHS.days_held, and ORDER BY direction.
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'John Cena', '1', '10', 'Boston', 'WrestleMania');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'John Cena', '10', '200', 'NY', 'SummerSlam');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'The Rock', '5', '2', 'Miami', 'Royal Rumble');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (4, 'The Rock', '2', '50', 'LA', 'Survivor Series');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Team A', 'Edge', 'Spear', '10:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT days_held AS reign FROM (SELECT days_held, event, COUNT(*) AS n FROM (SELECT wrestler_id, name, days_held AS reign, days_held, LOCATION, event, wrestler_id_other, days_held_other, location_other, event_other FROM (SELECT LHS.wrestler_id AS wrestler_id, LHS.name AS name, LHS.reign AS reign, LHS.days_held AS days_held, LHS.location AS LOCATION, LHS.event AS event, RHS.wrestler_id AS wrestler_id_other, RHS.days_held AS days_held_other, RHS.location AS location_other, RHS.event AS event_other FROM wrestler AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign))) GROUP BY days_held, event) ORDER BY reign;

/*
Gold Result:
('10',)
('2',)
*/

-- Prediction Query
SELECT Reign FROM wrestler GROUP BY Reign ORDER BY COUNT(*) DESC, Reign NULLS LAST LIMIT 1;

/*
Prediction Result:
('1',)
*/