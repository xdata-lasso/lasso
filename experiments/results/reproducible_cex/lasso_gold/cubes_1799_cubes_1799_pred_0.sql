-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1004, 'Renee Morales', 'participant', 'away', '327 Nelson Route
Lake Mark, WI 07832', 'drop');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1005, 'Lisa Hensley', 'raise', 'dark', '341 Michelle Light
Shawnstad, GA 49021', 'hear');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('Lisa Hensley', '341 Michelle Light\nShawnstad, GA 49021')
('Renee Morales', '327 Nelson Route\nLake Mark, WI 07832')
*/

-- Prediction Query
SELECT Name, LOCATION FROM wrestler;

/*
Prediction Result:
('Renee Morales', '327 Nelson Route\nLake Mark, WI 07832')
('Lisa Hensley', '341 Michelle Light\nShawnstad, GA 49021')
*/