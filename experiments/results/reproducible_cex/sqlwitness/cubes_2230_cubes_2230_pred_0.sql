-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO election (election_id, representative_id, date, votes, vote_percent, seats, place) VALUES (0, NULL, 'default1', 1.0, NULL, 0.0, 1.0), (1, NULL, 'default1', NULL, 0.0, NULL, NULL), (2, NULL, 'default2', NULL, 1.0, 1.0, 0.0), (3, NULL, 'default1', 0.0, 0.0, 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT votes FROM election ORDER BY votes, election.election_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT Votes FROM election ORDER BY Votes DESC, election.election_id NULLS LAST;

/*
Prediction Result:
(1.0,)
(0.0,)
(None,)
(None,)
*/