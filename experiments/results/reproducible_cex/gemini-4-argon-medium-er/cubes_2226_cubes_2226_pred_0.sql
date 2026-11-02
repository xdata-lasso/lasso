-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Bob', 'NY', 'Dem', '1950-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Alice', 'CA', 'Rep', '1960-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 1, '2020', 100, 50, 1, 1);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 2, '2020', 200, 60, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM (SELECT LHS.election_id AS election_id, LHS.representative_id AS representative_id, LHS.date AS date, LHS.votes AS votes, LHS.vote_percent AS vote_percent, LHS.seats AS seats, LHS.place AS place, RHS.name AS name, RHS.state AS state, RHS.party AS party, RHS.lifespan AS lifespan FROM election AS LHS INNER JOIN representative AS RHS ON (LHS.representative_id = RHS.representative_id)) ORDER BY name, date NULLS LAST;

/*
Gold Result:
('Alice', '2020')
('Bob', '2020')
*/

-- Prediction Query
SELECT T2.Name, T1.Date FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID;

/*
Prediction Result:
('Bob', '2020')
('Alice', '2020')
*/