-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'Orton', '1', '100', 'NY', 'Event1');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'Benjamin', '1', '50', 'LA', 'Event2');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (3, 'Cena', '2', '200', 'TX', 'Event3');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E1', '3', 'Team Beta', 'Orton', 'RKO', '10:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E2', '2', 'Team Alpha', 'Orton', 'RKO', '12:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E3', '1', 'Team Gamma', 'Benjamin', 'T-Bone', '15:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E4', '1', 'Team Delta', 'Cena', 'AA', '18:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E5', '2', 'Team Epsilon', NULL, 'Countout', '20:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "team" FROM "elimination" WHERE ("eliminated_by" = 'Orton' AND "eliminated_by" <> 'Benjamin') ORDER BY team, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('Team Alpha',)
('Team Beta',)
*/

-- Prediction Query
SELECT Team FROM Elimination WHERE Eliminated_By = 'Orton' INTERSECT SELECT Team FROM Elimination WHERE Eliminated_By = 'Benjamin';

/*
Prediction Result:
*/