-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO elimination (elimination_id, wrestler_id, team, eliminated_by, elimination_move, time) VALUES ('default2', NULL, 'default2', 'default2', 'default1', 'default2'), ('default1', NULL, NULL, NULL, 'default1', 'default2'), ('unique_2', NULL, 'default2', 'default2', 'default1', 'default1'), ('unique_3', NULL, 'default2', NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT team, COUNT(*) AS n FROM elimination GROUP BY team) WHERE (n >= 3) ORDER BY team;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*) > 3;

/*
Prediction Result:
*/