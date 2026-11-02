-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests unintended JOINs or filtering based on the Elimination table (wrestlers with 0, 1, and multiple eliminations).
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (10, 'Bret Hart', '5', '300', 'Calgary', 'Survivor Series');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (20, 'Shawn Michaels', '4', '250', 'San Antonio', 'Royal Rumble');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (30, 'Undertaker', '7', '500', 'Houston', 'WrestleMania');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '10', 'Team WWF', 'Stone Cold', 'Stunner', '15:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '10', 'Team Hart', 'Lex Luger', 'Rack', '22:30');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E3', '20', 'DX', 'Kane', 'Chokeslam', '10:15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('Bret Hart',)
('Shawn Michaels',)
('Undertaker',)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held DESC, wrestler.wrestler_id NULLS LAST;

/*
Prediction Result:
('Undertaker',)
('Bret Hart',)
('Shawn Michaels',)
*/