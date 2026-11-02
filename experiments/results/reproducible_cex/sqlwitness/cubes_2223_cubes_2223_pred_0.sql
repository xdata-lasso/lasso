-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (10001, NULL, NULL, NULL, 'default2'), (0, NULL, 'default1', 'default1', 'default1'), (10000, NULL, 'default1', 'default2', 'default1'), (9999, 'default2', 'default2', 'default2', 'default1');
INSERT INTO election (election_id, representative_id, date, votes, vote_percent, seats, place) VALUES (0, 9999, 'default1', NULL, 0.0, 10001.0, 0.0), (2, 10001, 'default1', 10000.0, 0.0, 2.0, 1.0), (1, 10001, NULL, 10000.0, 10000.0, 10000.0, 1.0), (10000, 10001, 'default1', 10000.0, 2.0, 9999.0, 10001.0), (9999, 10000, 'default1', 2.0, 10001.0, 10001.0, 1.0), (10001, NULL, 'default2', 2.0, 1.0, 9999.0, 9999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM election WHERE (votes >= 10000.0)) AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID WHERE Votes > 10000;

/*
Prediction Result:
*/