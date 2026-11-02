-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (1, 'default1', 'Indiana', 'New York', 'Indiana'), (0, 'New York', 'default2', 'default1', 'New York'), (2, NULL, 'default1', NULL, 'default1'), (3, 'default2', 'default1', 'default1', 'New York'), (4, 'default2', 'default2', 'default1', NULL), (5, 'Indiana', 'New York', 'Indiana', NULL), (6, NULL, NULL, 'default1', NULL), (7, 'default1', 'New York', 'Indiana', 'default1'), (8, 'New York', 'New York', 'default2', 'Indiana'), (9, 'Indiana', 'Indiana', 'Indiana', 'Indiana'), (10, 'default2', 'default2', 'New York', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lifespan" FROM "representative" WHERE ("state" = 'New York' OR "state" = 'Indiana') ORDER BY lifespan, representative.representative_id NULLS LAST;

/*
Gold Result:
(None,)
('Indiana',)
('Indiana',)
('Indiana',)
('default1',)
*/

-- Prediction Query
SELECT Lifespan FROM representative WHERE State = 'New York' OR State = 'Indiana';

/*
Prediction Result:
('Indiana',)
(None,)
('default1',)
('Indiana',)
('Indiana',)
*/