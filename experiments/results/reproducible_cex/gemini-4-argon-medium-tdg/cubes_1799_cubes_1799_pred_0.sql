-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of order relative to Wrestler_ID), tie-breaking by Wrestler_ID, and spurious joins with Elimination table (rows with 0, 1, and multiple eliminations).
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'Alpha', '1', '100', 'New York', 'Event A');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'Bravo', '2', '50', 'Chicago', 'Event B');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'Bravo', '1', '200', 'Boston', 'Event C');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Red', 'Alpha', 'Slam', '05:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '1', 'Blue', 'Charlie', 'Dropkick', '10:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('Alpha', 'New York')
('Bravo', 'Chicago')
('Bravo', 'Boston')
*/

-- Prediction Query
SELECT Name, LOCATION FROM wrestler;

/*
Prediction Result:
('Bravo', 'Chicago')
('Bravo', 'Boston')
('Alpha', 'New York')
*/