-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'Randy Orton', '1', '100', 'USA', 'Survivor Series');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '1', 'Team Orton', 'Batista', 'RKO', '10:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Team Orton', 'Triple H', 'Pedigree', '12:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E3', '1', 'TeamCena', 'Edge', 'Spear', '15:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E4', '1', 'team orton', 'Kane', 'Chokeslam', '08:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E5', '1', NULL, 'Undertaker', 'Tombstone', '20:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "elimination_move" FROM "elimination" WHERE ("team" = 'Team Orton') ORDER BY elimination_move, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('Pedigree',)
('RKO',)
*/

-- Prediction Query
SELECT Elimination_Move FROM Elimination WHERE Team = 'Team Orton';

/*
Prediction Result:
('RKO',)
('Pedigree',)
*/