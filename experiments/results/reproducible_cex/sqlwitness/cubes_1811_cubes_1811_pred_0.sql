-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (1, 'default1', 'default1', 'default1', 'default1', NULL), (0, 'Team Orton', 'default2', 'Team Orton', 'default1', NULL), (2, 'default2', 'default2', 'Team Orton', 'default2', 'default1'), (3, 'default1', 'default2', NULL, 'default1', 'default2'), (4, 'Team Orton', 'Team Orton', 'default2', NULL, 'Team Orton'), (5, 'Team Orton', 'default1', 'default2', NULL, NULL), (6, 'default2', 'Team Orton', NULL, 'default1', 'Team Orton'), (7, 'default2', NULL, 'default1', 'default1', NULL), (8, 'default1', 'Team Orton', 'Team Orton', 'Team Orton', 'Team Orton'), (9, NULL, NULL, 'Team Orton', NULL, NULL), (10, 'default2', 'default1', 'default1', 'default1', NULL);
INSERT INTO elimination (elimination_id, wrestler_id, team, eliminated_by, elimination_move, time) VALUES ('Team Orton', 0, 'default2', NULL, 'default1', NULL), ('default1', 7, 'default2', NULL, NULL, 'Team Orton'), ('default2', 8, 'default1', NULL, 'Team Orton', 'default2'), ('unique_3', 4, 'Team Orton', 'Team Orton', NULL, NULL), ('unique_4', 3, 'Team Orton', 'Team Orton', 'Team Orton', 'default2'), ('unique_5', 0, 'Team Orton', NULL, NULL, 'default2'), ('unique_6', NULL, 'default1', NULL, 'default2', 'Team Orton'), ('unique_7', 0, 'Team Orton', NULL, 'default1', NULL), ('unique_8', 6, 'default1', NULL, 'Team Orton', 'Team Orton'), ('unique_9', 3, NULL, 'default1', 'Team Orton', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "elimination_move" FROM "elimination" WHERE ("team" = 'Team Orton') ORDER BY elimination_move, elimination.elimination_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Team Orton',)
('default1',)
*/

-- Prediction Query
SELECT Elimination_Move FROM Elimination WHERE Team = 'Team Orton';

/*
Prediction Result:
(None,)
('Team Orton',)
(None,)
('default1',)
*/