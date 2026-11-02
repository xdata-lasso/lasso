-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'John Doe', '1', '100', 'NY', 'Main');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'Jane Smith', '2', '200', 'LA', 'Final');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'Bob Johnson', '1', '50', 'TX', 'Open');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (4, 'Alice Brown', '3', '300', 'FL', 'Summer');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Zeta', 'Wrestler X', 'Pin', '05:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '2', 'Zeta', 'Wrestler Y', 'Submission', '10:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E3', '3', 'Zeta', 'Wrestler Z', 'Pin', '15:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E4', '4', 'Zeta', 'Wrestler W', 'DQ', '20:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E5', '1', 'Alpha', 'Wrestler X', 'Pin', '06:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E6', '2', 'Alpha', 'Wrestler Y', 'Countout', '11:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E7', '3', 'Alpha', 'Wrestler Z', 'Pin', '16:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E8', '1', 'Beta', 'Wrestler X', 'Pin', '07:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E9', '2', 'Beta', 'Wrestler Y', 'Submission', '12:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E10', '1', 'Gamma', 'Wrestler X', 'Pin', '08:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT team, COUNT(*) AS n FROM elimination GROUP BY team) WHERE (n >= 3) ORDER BY team;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*) > 3;

/*
Prediction Result:
('Zeta',)
*/