-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO wrestler (wrestler_id, name, reign, days_held, location, event) VALUES (0, 'default1', 'default2', 'default1', 'default1', 'default1'), (1, NULL, NULL, 'default1', NULL, 'default2'), (2, 'default1', 'default2', NULL, NULL, 'default1'), (3, 'default1', 'default1', 'default2', 'default1', NULL), (4, NULL, NULL, 'default1', 'default1', 'default1'), (5, NULL, NULL, 'default2', 'default2', NULL), (6, NULL, NULL, 'default1', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST;

/*
Gold Result:
(None, None)
(None, 'default1')
(None, 'default2')
(None, 'default2')
('default1', 'default1')
('default1', None)
('default1', 'default1')
*/

-- Prediction Query
SELECT Name, LOCATION FROM wrestler;

/*
Prediction Result:
('default1', 'default1')
(None, None)
('default1', None)
('default1', 'default1')
(None, 'default1')
(None, 'default2')
(None, 'default2')
*/