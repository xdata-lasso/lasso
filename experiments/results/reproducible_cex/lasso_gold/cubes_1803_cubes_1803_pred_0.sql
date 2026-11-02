-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1001, 'Allison Hill', 'agreement', 'rate', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 'forward');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1002, 'Noah Rhodes', 'option', 'science', '1849 Ray Squares
North Donnaport, CO 31013', 'difference');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1003, 'Angie Henderson', 'decide', 'offer', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'reality');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1004, 'Daniel Wagner', 'sense', 'kind', '503 Linda Locks
Carlshire, FM 94599', 'money');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/