-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'John Doe', 'CA', 'Independent', '1950-2020');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 1, '2000', 100.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 1, '2002', 200.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT votes FROM election ORDER BY votes, election.election_id NULLS LAST;

/*
Gold Result:
(100.0,)
(200.0,)
*/

-- Prediction Query
SELECT Votes FROM election ORDER BY Votes DESC, election.election_id NULLS LAST;

/*
Prediction Result:
(200.0,)
(100.0,)
*/