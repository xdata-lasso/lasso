-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1001, 'Allison Hill', 'all', 'early', '863 Lawrence Valleys
Port Lindachester, MA 36922', 'hear');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1002, 'Noah Rhodes', 'better', 'mouth', '16155 Roman Stream Suite 816
New Kellystad, OK 25704', 'determine');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1003, 'Angie Henderson', 'discover', 'play', '341 Michelle Light
Shawnstad, GA 49021', 'religious');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Ethiopia', 1001, 'result', 'raise', 'North Macedonia', 'shoulder');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Reunion', 1001, 'result', 'away', 'Chile', 'election');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Vietnam', 1001, 'result', 'politics', 'Martinique', 'common');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT team, COUNT(*) AS n FROM elimination GROUP BY team) WHERE (n >= 3) ORDER BY team;

/*
Gold Result:
('result',)
*/

-- Prediction Query
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*) > 3;

/*
Prediction Result:
*/