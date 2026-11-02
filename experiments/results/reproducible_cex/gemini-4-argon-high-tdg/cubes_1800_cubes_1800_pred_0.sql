-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'John Cena', '2', '140', 'New York , NY', 'WrestleMania');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'Randy Orton', '10', '90', 'Chicago , IL', 'SummerSlam');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'AJ Styles', '1', '210', 'Tokyo , Japan', 'Wrestle Kingdom');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (4, 'CM Punk', '2', '434', 'Boston , MA', 'Survivor Series');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (5, 'Triple H', '2', '140', 'New York , NY', 'WrestleMania');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'Team WWE', 'Edge', 'Spear', '12:30');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '5', 'Team Raw', 'Shawn Michaels', 'Sweet Chin Music', '18:45');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E3', '5', 'Team DX', 'Undertaker', 'Tombstone', '25:10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "reign" FROM "wrestler" WHERE ("location" <> 'Tokyo , Japan') ORDER BY reign, "reign" NULLS LAST;

/*
Gold Result:
('10',)
('2',)
*/

-- Prediction Query
SELECT DISTINCT Reign FROM wrestler WHERE LOCATION <> 'Tokyo , Japan';

/*
Prediction Result:
('2',)
('10',)
*/