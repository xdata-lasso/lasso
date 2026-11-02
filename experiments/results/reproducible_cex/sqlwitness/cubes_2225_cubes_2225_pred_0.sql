-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (0, 'default2', 'default1', NULL, 'default2'), (1, NULL, 'default1', NULL, NULL), (2, NULL, 'default1', NULL, NULL);
INSERT INTO election (election_id, representative_id, date, votes, vote_percent, seats, place) VALUES (1, 1, 'default1', NULL, 1.0, 0.0, 1.0), (2, NULL, 'default1', NULL, 1.0, 0.0, 2.0), (0, 1, NULL, 1.0, 0.0, 2.0, NULL), (3, 0, NULL, 0.0, 1.0, 0.0, 2.0), (4, 1, NULL, 2.0, 1.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lifespan FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY lifespan;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT T2.Lifespan FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY Vote_Percent DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
(None,)
('default2',)
(None,)
(None,)
*/