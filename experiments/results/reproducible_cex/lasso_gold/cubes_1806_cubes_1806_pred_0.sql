-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (0, 'Scott Brown', 'ready', 'race', '513 James Mission Apt. 624
Wrightland, NV 72633', 'billion');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (150, 'Scott Brown', 'better', 'with', '67736 Franklin Alley
Bakermouth, LA 55945', 'same');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (20, 'Megan Young', 'message', 'clear', '98050 Breanna Parkway
North Susan, CO 24857', 'authority');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('Megan Young',)
('Scott Brown',)
('Scott Brown',)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held DESC, wrestler.wrestler_id NULLS LAST;

/*
Prediction Result:
('Scott Brown',)
('Scott Brown',)
('Megan Young',)
*/