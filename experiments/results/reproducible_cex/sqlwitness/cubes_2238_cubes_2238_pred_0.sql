-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (0, NULL, NULL, 'default1', 'default2'), (2, 'default1', 'default1', NULL, 'default1'), (1, 'default2', 'default1', 'default1', 'default2');
INSERT INTO election (election_id, representative_id, date, votes, vote_percent, seats, place) VALUES (2, NULL, 'default2', NULL, 2.0, 2.0, NULL), (1, 1, 'default1', 1.0, 1.0, 1.0, 2.0), (0, 2, 'default2', 1.0, 0.0, 1.0, 0.0), (3, 0, NULL, 1.0, 1.0, NULL, 1.0), (4, 2, NULL, 0.0, 2.0, 0.0, 0.0), (5, 1, NULL, 1.0, 0.0, 2.0, 0.0), (6, 2, 'default1', 2.0, NULL, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('default1',)
('default1',)
('default2',)
(None,)
('default2',)
('default1',)
*/