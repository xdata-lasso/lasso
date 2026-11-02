-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1016, 'Brenda White', 'mention', 'difficult', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 'customer');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1017, 'Jose Ramirez', 'institution', 'enjoy', '8108 Tanya Terrace
East Richard, NJ 28517', 'treatment');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "reign" FROM "wrestler" WHERE ("location" <> 'Tokyo , Japan') ORDER BY reign, "reign" NULLS LAST;

/*
Gold Result:
('institution',)
('mention',)
*/

-- Prediction Query
SELECT DISTINCT Reign FROM wrestler WHERE LOCATION <> 'Tokyo , Japan';

/*
Prediction Result:
('mention',)
('institution',)
*/