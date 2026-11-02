-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1001, 'Allison Hill', 'dog', 'chair', '600 Jeffery Parkways
New Jamesside, MT 29394', 'list');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Namibia', 1001, 'fall', 'Orton', 'Sudan', 'true');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "team" FROM "elimination" WHERE ("eliminated_by" = 'Orton' AND "eliminated_by" <> 'Benjamin') ORDER BY team, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('fall',)
*/

-- Prediction Query
SELECT Team FROM Elimination WHERE Eliminated_By = 'Orton' INTERSECT SELECT Team FROM Elimination WHERE Eliminated_By = 'Benjamin';

/*
Prediction Result:
*/