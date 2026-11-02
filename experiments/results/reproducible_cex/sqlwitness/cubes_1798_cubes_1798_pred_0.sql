-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (1, 'default1', 'default2', NULL, NULL, 'default1'), (0, NULL, 'default1', 'default2', NULL, 'default1'), (2, NULL, 'default1', 'default1', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT reign, days_held FROM wrestler ORDER BY reign, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
('default1', 'default2')
('default1', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT Reign, Days_held FROM wrestler;

/*
Prediction Result:
('default1', 'default2')
('default2', None)
('default1', 'default1')
*/