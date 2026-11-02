-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (0, 'default2', 'default1', 'default2', 'default2');
INSERT INTO election (election_id, representative_id, date, votes, vote_percent, seats, place) VALUES (0, 0, 'default1', 0.0, 0.0, NULL, NULL), (1, 0, NULL, 1.0, 0.0, NULL, NULL), (2, 0, 'default1', 0.0, 1.0, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, vote_percent FROM election ORDER BY date, election.election_id NULLS LAST;

/*
Gold Result:
(None, 0.0)
('default1', 0.0)
('default1', 1.0)
*/

-- Prediction Query
SELECT Date, Vote_Percent FROM election;

/*
Prediction Result:
('default1', 0.0)
(None, 0.0)
('default1', 1.0)
*/