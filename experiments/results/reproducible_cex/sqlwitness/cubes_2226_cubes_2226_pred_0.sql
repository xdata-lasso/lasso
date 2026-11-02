-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (1, 'default2', 'default1', 'default2', NULL);
INSERT INTO election (election_id, representative_id, date, votes, vote_percent, seats, place) VALUES (0, NULL, 'default2', 0.0, 1.0, 1.0, 1.0), (1, 1, 'default2', 1.0, 0.0, NULL, NULL), (2, NULL, NULL, 1.0, NULL, 0.0, 1.0), (3, NULL, 'default2', 1.0, NULL, 1.0, 1.0), (4, 1, NULL, NULL, 0.0, 0.0, NULL), (5, 1, 'default1', 1.0, 0.0, 0.0, 0.0), (6, 1, 'default2', NULL, 1.0, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM (SELECT LHS.election_id AS election_id, LHS.representative_id AS representative_id, LHS.date AS date, LHS.votes AS votes, LHS.vote_percent AS vote_percent, LHS.seats AS seats, LHS.place AS place, RHS.name AS name, RHS.state AS state, RHS.party AS party, RHS.lifespan AS lifespan FROM election AS LHS INNER JOIN representative AS RHS ON (LHS.representative_id = RHS.representative_id)) ORDER BY name, date NULLS LAST;

/*
Gold Result:
('default2', 'default1')
('default2', 'default2')
('default2', 'default2')
('default2', None)
*/

-- Prediction Query
SELECT T2.Name, T1.Date FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID;

/*
Prediction Result:
('default2', 'default2')
('default2', None)
('default2', 'default1')
('default2', 'default2')
*/