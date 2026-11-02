-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Wrestler_ID, and spurious joins with Elimination (1-to-many and 1-to-0 relationships).
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (10, 'Brock Lesnar', '1', '126', 'Miami, FL', 'SummerSlam');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (2, 'John Cena', '3', '380', 'Boston, MA', 'Unforgiven');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (5, 'John Cena', '4', '84', 'Chicago, IL', 'WrestleMania');
INSERT INTO wrestler (Wrestler_ID, Name, Reign, Days_held, Location, Event) VALUES (1, 'Undertaker', '2', '133', 'Houston, TX', 'Royal Rumble');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E1', '10', 'Raw', 'Roman Reigns', 'Spear', '15:30');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E2', '10', 'SmackDown', 'Drew McIntyre', 'Claymore', '22:10');
INSERT INTO Elimination (Elimination_ID, Wrestler_ID, Team, Eliminated_By, Elimination_Move, Time) VALUES ('E3', '2', 'Raw', 'Edge', 'Spear', '30:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('Brock Lesnar', 'Miami, FL')
('John Cena', 'Boston, MA')
('John Cena', 'Chicago, IL')
('Undertaker', 'Houston, TX')
*/

-- Prediction Query
SELECT Name, LOCATION FROM wrestler;

/*
Prediction Result:
('Undertaker', 'Houston, TX')
('John Cena', 'Boston, MA')
('John Cena', 'Chicago, IL')
('Brock Lesnar', 'Miami, FL')
*/