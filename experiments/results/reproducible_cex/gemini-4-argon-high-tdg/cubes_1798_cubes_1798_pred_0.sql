-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'John Cena', '2', '90', 'Boston, MA', 'SummerSlam');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'Zack Ryder', '10', '300', 'New York, NY', 'WrestleMania');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (3, 'Adam Cole', '10', '150', 'Chicago, IL', 'Survivor Series');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (4, 'Randy Orton', '1', '50', 'St. Louis, MO', 'Royal Rumble');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E1', '1', 'Team Raw', 'Edge', 'Spear', '12:30');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E2', '1', 'Team WWE', 'CM Punk', 'GTS', '25:10');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E3', '3', 'Team NXT', 'Seth Rollins', 'Curb Stomp', '18:45');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT reign, days_held FROM wrestler ORDER BY reign, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('1', '50')
('10', '300')
('10', '150')
('2', '90')
*/

-- Prediction Query
SELECT Reign, Days_held FROM wrestler;

/*
Prediction Result:
('2', '90')
('10', '300')
('10', '150')
('1', '50')
*/