-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1001, 'Allison Hill', 'dog', 'chair', '600 Jeffery Parkways
New Jamesside, MT 29394', 'list');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Namibia', 1001, 'table', 'Punk', 'Albania', 'sure');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Fiji', 1001, 'true', 'Orton', 'Senegal', 'collection');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM "elimination" WHERE ("eliminated_by" = 'Punk' OR "eliminated_by" = 'Orton') ORDER BY TIME, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('collection',)
('sure',)
*/

-- Prediction Query
SELECT TIME FROM elimination WHERE Eliminated_By = 'Punk' OR Eliminated_By = 'Orton';

/*
Prediction Result:
('sure',)
('collection',)
*/