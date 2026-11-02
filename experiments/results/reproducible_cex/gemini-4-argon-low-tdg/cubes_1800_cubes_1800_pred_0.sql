-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'John Cena', '1', '100', 'Tokyo , Japan', 'Live Event');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'The Rock', '2', '50', 'New York, NY', 'WrestleMania');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'Stone Cold', '2', '75', 'Austin, TX', 'Raw');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (4, 'Undertaker', '10', '200', 'Chicago, IL', 'Survivor Series');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (5, 'Kane', NULL, '10', 'Boston, MA', 'SmackDown');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (6, 'Triple H', '3', '90', NULL, 'SummerSlam');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (7, 'Shawn Michaels', '4', '120', 'Tokyo, Japan', 'In Your House');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '2', 'Team WWF', 'Chris Jericho', 'Pinfall', '15:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '2', 'Team WWF', 'Kurt Angle', 'Submission', '20:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "reign" FROM "wrestler" WHERE ("location" <> 'Tokyo , Japan') ORDER BY reign, "reign" NULLS LAST;

/*
Gold Result:
(None,)
('10',)
('2',)
('4',)
*/

-- Prediction Query
SELECT DISTINCT Reign FROM wrestler WHERE LOCATION <> 'Tokyo , Japan';

/*
Prediction Result:
('2',)
('10',)
(None,)
('4',)
*/