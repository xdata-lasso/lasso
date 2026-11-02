-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'Ziggler', '1', '100', 'Miami', 'Survivor Series');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'Cena', '3', '250', 'Toronto', 'SummerSlam');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (5, 'Austin', '2', '90', 'Dallas', 'WrestleMania');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (10, 'Cena', '1', '45', 'Boston', 'Royal Rumble');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E1', '1', 'Team Red', 'Orton', 'RKO', '12:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E2', '2', 'Team Blue', 'Edge', 'Spear', '15:30');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E3', '2', 'Team Blue', 'Kane', 'Chokeslam', '20:10');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E4', '5', 'Team Texas', 'Rock', 'Rock Bottom', '25:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('Austin', 'Dallas')
('Cena', 'Toronto')
('Cena', 'Boston')
('Ziggler', 'Miami')
*/

-- Prediction Query
SELECT Name, LOCATION FROM wrestler;

/*
Prediction Result:
('Ziggler', 'Miami')
('Cena', 'Toronto')
('Austin', 'Dallas')
('Cena', 'Boston')
*/