-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (0, 'default2', 'default1', NULL, NULL), (1, 'default2', 'default2', 'default1', 'default1'), (2, NULL, 'default1', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, party FROM representative ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default2', None)
('default2', 'default1')
*/

-- Prediction Query
SELECT Name, Party FROM representative;

/*
Prediction Result:
('default2', None)
('default2', 'default1')
(None, 'default1')
*/