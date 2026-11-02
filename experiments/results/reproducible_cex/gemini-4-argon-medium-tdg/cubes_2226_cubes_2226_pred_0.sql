-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY name ASC, date ASC NULLS LAST, and ensures NULLs in both Name and Date are handled properly.
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Zack', 'WA', 'Dem', '1980-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Aaron', 'OR', 'Rep', '1975-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, NULL, 'NV', 'Ind', '1990-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 1, '2022-01-01', 100.0, 10.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 2, '2020-05-01', 200.0, 20.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (103, 2, '2018-05-01', 300.0, 30.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (104, 2, NULL, 400.0, 40.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (105, 3, '2019-01-01', 500.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (106, 3, NULL, 600.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM (SELECT LHS.election_id AS election_id, LHS.representative_id AS representative_id, LHS.date AS date, LHS.votes AS votes, LHS.vote_percent AS vote_percent, LHS.seats AS seats, LHS.place AS place, RHS.name AS name, RHS.state AS state, RHS.party AS party, RHS.lifespan AS lifespan FROM election AS LHS INNER JOIN representative AS RHS ON (LHS.representative_id = RHS.representative_id)) ORDER BY name, date NULLS LAST;

/*
Gold Result:
(None, '2019-01-01')
(None, None)
('Aaron', '2018-05-01')
('Aaron', '2020-05-01')
('Aaron', None)
('Zack', '2022-01-01')
*/

-- Prediction Query
SELECT T2.Name, T1.Date FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID;

/*
Prediction Result:
('Zack', '2022-01-01')
('Aaron', '2020-05-01')
('Aaron', '2018-05-01')
('Aaron', None)
(None, '2019-01-01')
(None, None)
*/