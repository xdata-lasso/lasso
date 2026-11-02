-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("Wrestler_ID", "Name") VALUES (1, 'Wrestler 1');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '1', 'Team Orton', 'B', 'Move Z', '10:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Team Orton', 'A', 'Move A', '05:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "elimination_move" FROM "elimination" WHERE ("team" = 'Team Orton') ORDER BY elimination_move, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('Move A',)
('Move Z',)
*/

-- Prediction Query
SELECT Elimination_Move FROM Elimination WHERE Team = 'Team Orton';

/*
Prediction Result:
('Move Z',)
('Move A',)
*/