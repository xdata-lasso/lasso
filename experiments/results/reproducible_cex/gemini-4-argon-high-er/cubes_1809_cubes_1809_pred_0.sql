-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("Wrestler_ID", "Name", "Reign", "Days_held", "Location", "Event") VALUES (1, 'A', '1', '10', 'Loc', 'Ev');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('1', '1', 'T1', 'Punk', 'M1', '20:00');
INSERT INTO "Elimination" ("Elimination_ID", "Wrestler_ID", "Team", "Eliminated_By", "Elimination_Move", "Time") VALUES ('2', '1', 'T1', 'Orton', 'M2', '10:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM "elimination" WHERE ("eliminated_by" = 'Punk' OR "eliminated_by" = 'Orton') ORDER BY TIME, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('10:00',)
('20:00',)
*/

-- Prediction Query
SELECT TIME FROM elimination WHERE Eliminated_By = 'Punk' OR Eliminated_By = 'Orton';

/*
Prediction Result:
('20:00',)
('10:00',)
*/