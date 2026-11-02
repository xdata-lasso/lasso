-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'Punk', '1', '434', 'Chicago', 'Survivor Series');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'Orton', '2', '203', 'St. Louis', 'Royal Rumble');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (3, 'Cena', '3', '380', 'Boston', 'WrestleMania');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (4, 'Edge', '1', '105', 'Toronto', 'SummerSlam');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('3', '3', 'Raw', 'Punk', 'GTS', '15:30');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('1', '4', 'SmackDown', 'Orton', 'RKO', '22:10');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('2', '3', 'Raw', 'Punk', 'Dropkick', '04:15');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('4', '1', 'Raw', 'Cena', 'AA', '10:00');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('5', '2', 'SmackDown', 'Edge', 'Spear', '01:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM "elimination" WHERE ("eliminated_by" = 'Punk' OR "eliminated_by" = 'Orton') ORDER BY TIME, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('04:15',)
('15:30',)
('22:10',)
*/

-- Prediction Query
SELECT TIME FROM elimination WHERE Eliminated_By = 'Punk' OR Eliminated_By = 'Orton';

/*
Prediction Result:
('15:30',)
('22:10',)
('04:15',)
*/