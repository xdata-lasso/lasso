-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'CM Punk', '1', '100', 'Chicago', 'RAW');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'Randy Orton', '2', '50', 'St. Louis', 'SmackDown');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Team A', 'Punk', 'GTS', '10:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '1', 'Team A', 'Orton', 'RKO', '05:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E3', '2', 'Team B', 'Cena', 'AA', '01:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E4', '2', 'Team B', NULL, 'None', '02:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM "elimination" WHERE ("eliminated_by" = 'Punk' OR "eliminated_by" = 'Orton') ORDER BY TIME, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('05:00',)
('10:00',)
*/

-- Prediction Query
SELECT TIME FROM elimination WHERE Eliminated_By = 'Punk' OR Eliminated_By = 'Orton';

/*
Prediction Result:
('10:00',)
('05:00',)
*/