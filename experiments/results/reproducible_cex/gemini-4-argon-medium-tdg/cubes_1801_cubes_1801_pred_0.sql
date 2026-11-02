-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'John Cena', '1', '100', 'NY', 'WrestleMania');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'The Rock', '2', '50', 'LA', 'SummerSlam');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (3, 'Undertaker', '3', '200', 'TX', 'Survivor Series');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (4, 'Triple H', '4', '80', 'MA', 'Royal Rumble');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E1', '1', 'Team Bravo', 'Orton', 'RKO', '10:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E2', '2', 'Team Bravo', 'Batista', 'Batista Bomb', '12:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E3', '3', 'Team Bravo', 'Edge', 'Spear', '15:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E4', '1', 'Team Alpha', 'Kane', 'Chokeslam', '05:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E5', '2', 'Team Alpha', 'Kane', 'Chokeslam', '06:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E6', '3', 'Team Alpha', 'Big Show', 'KO Punch', '08:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E7', '4', 'Team Alpha', 'Lesnar', 'F5', '20:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E8', '1', 'Team Charlie', 'Michaels', 'Sweet Chin Music', '11:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E9', '2', 'Team Charlie', 'Jericho', 'Codebreaker', '13:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E10', '3', 'Team Delta', 'Angle', 'Angle Slam', '02:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT team, COUNT(*) AS n FROM elimination GROUP BY team) WHERE (n >= 3) ORDER BY team;

/*
Gold Result:
('Team Alpha',)
('Team Bravo',)
*/

-- Prediction Query
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*) > 3;

/*
Prediction Result:
('Team Alpha',)
*/