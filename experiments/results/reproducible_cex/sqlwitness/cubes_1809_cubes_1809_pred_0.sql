-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (1, 'Orton', 'Orton', 'Orton', 'Punk', NULL), (0, 'Orton', 'Orton', 'default1', 'default2', NULL), (2, 'default1', 'Orton', 'Orton', NULL, 'Punk'), (3, 'Orton', 'default2', 'default1', 'default1', 'Punk'), (4, 'Punk', 'default2', 'Punk', 'Orton', 'default1'), (5, NULL, 'default2', 'Orton', 'default1', 'default2');
INSERT INTO elimination (elimination_id, wrestler_id, team, eliminated_by, elimination_move, time) VALUES ('default2', 4, 'default2', 'Punk', 'Orton', NULL), ('Orton', NULL, 'Punk', 'Punk', NULL, 'Orton'), ('Punk', 0, 'Orton', NULL, NULL, 'Orton'), ('default1', 4, NULL, 'default2', 'Punk', 'Punk'), ('unique_4', 3, 'Orton', 'Orton', NULL, NULL), ('unique_5', NULL, 'default1', NULL, 'default1', 'default1'), ('unique_6', NULL, 'default2', 'default2', 'Orton', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM "elimination" WHERE ("eliminated_by" = 'Punk' OR "eliminated_by" = 'Orton') ORDER BY TIME, elimination.elimination_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Orton',)
*/

-- Prediction Query
SELECT TIME FROM elimination WHERE Eliminated_By = 'Punk' OR Eliminated_By = 'Orton';

/*
Prediction Result:
(None,)
('Orton',)
(None,)
*/