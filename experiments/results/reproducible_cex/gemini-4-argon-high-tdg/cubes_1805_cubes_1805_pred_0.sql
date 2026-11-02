-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'Shawn Michaels', '1', '28', 'San Antonio', 'Royal Rumble');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (2, 'Kurt Angle', '2', '126', 'Pittsburgh', 'No Way Out');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (3, 'Chris Jericho', '1', '98', 'Chicago', 'WrestleMania');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (4, 'Edge', '3', '76', 'Toronto', 'SummerSlam');
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (5, 'Rey Mysterio', '1', '112', 'San Diego', 'Survivor Series');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E1', '1', 'SmackDown', 'Orton', 'RKO', '14:20');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E2', '2', 'Raw', 'Orton', 'RKO', '18:05');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E3', '3', 'Raw', 'Orton', 'Clothesline', '22:10');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E4', '4', 'ECW', 'Benjamin', 'Paydirt', '09:45');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('E5', '5', 'NXT', 'Cena', 'Attitude Adjustment', '25:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "team" FROM "elimination" WHERE ("eliminated_by" = 'Orton' AND "eliminated_by" <> 'Benjamin') ORDER BY team, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('Raw',)
('Raw',)
('SmackDown',)
*/

-- Prediction Query
SELECT Team FROM Elimination WHERE Eliminated_By = 'Orton' INTERSECT SELECT Team FROM Elimination WHERE Eliminated_By = 'Benjamin';

/*
Prediction Result:
*/