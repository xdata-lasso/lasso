-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join behavior, DISTINCT elimination, ORDER BY sorting, and partial party participation in elections
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice', 'NY', 'Republican', '1950-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Bob', 'CA', 'Republican', '1960-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Charlie', 'TX', 'Democratic', '1970-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'David', 'FL', 'Independent', '1980-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'Eve', 'OH', 'Independent', '1985-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (6, 'Frank', 'WA', 'Green', '1990-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 2, '2020-11-03', 5000.0, 55.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 3, '2020-11-03', 6000.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT * FROM representative AS LHS WHERE NOT EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY party;

/*
Gold Result:
('Green',)
('Independent',)
('Republican',)
*/

-- Prediction Query
SELECT T2.Party FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes ASC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Republican',)
*/