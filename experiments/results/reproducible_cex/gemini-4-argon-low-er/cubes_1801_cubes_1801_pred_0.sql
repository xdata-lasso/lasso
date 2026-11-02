-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("Wrestler_ID", "Name") VALUES (1, 'John');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team") VALUES ('1', '1', 'Team A');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team") VALUES ('2', '1', 'Team A');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team") VALUES ('3', '1', 'Team A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT team, COUNT(*) AS n FROM elimination GROUP BY team) WHERE (n >= 3) ORDER BY team;

/*
Gold Result:
('Team A',)
*/

-- Prediction Query
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*) > 3;

/*
Prediction Result:
*/