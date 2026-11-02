-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (1, 'Orton', 'default1', 'Benjamin', 'Orton', 'default1'), (0, 'default2', 'default1', 'default1', 'Orton', 'default1'), (2, NULL, 'Orton', 'default2', 'Benjamin', 'default1'), (3, 'default2', NULL, NULL, 'default1', 'default1'), (4, 'Benjamin', 'default2', 'default2', 'Orton', 'Orton'), (5, NULL, NULL, 'default1', 'default1', 'default1');
INSERT INTO elimination (elimination_id, wrestler_id, team, eliminated_by, elimination_move, time) VALUES ('Orton', 3, 'Orton', 'default1', 'Orton', 'default2'), ('Benjamin', 0, 'default2', 'default1', 'default2', 'default2'), ('default1', 1, 'Orton', 'Orton', 'default2', 'Orton'), ('default2', 4, 'default1', 'default2', 'default1', 'Orton');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "team" FROM "elimination" WHERE ("eliminated_by" = 'Orton' AND "eliminated_by" <> 'Benjamin') ORDER BY team, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('Orton',)
*/

-- Prediction Query
SELECT Team FROM Elimination WHERE Eliminated_By = 'Orton' INTERSECT SELECT Team FROM Elimination WHERE Eliminated_By = 'Benjamin';

/*
Prediction Result:
*/