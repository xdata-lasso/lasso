-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (0, 'Tokyo , Japan', NULL, 'default1', 'Tokyo , Japan', 'default2'), (1, 'default2', 'Tokyo , Japan', 'default2', NULL, 'default2'), (2, NULL, 'default1', 'default2', NULL, 'default2'), (3, 'default2', 'default1', 'default2', 'default2', NULL), (4, 'default2', NULL, NULL, 'default2', NULL), (5, 'Tokyo , Japan', 'default1', NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "reign" FROM "wrestler" WHERE ("location" <> 'Tokyo , Japan') ORDER BY reign, "reign" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT Reign FROM wrestler WHERE LOCATION <> 'Tokyo , Japan';

/*
Prediction Result:
('default1',)
(None,)
*/