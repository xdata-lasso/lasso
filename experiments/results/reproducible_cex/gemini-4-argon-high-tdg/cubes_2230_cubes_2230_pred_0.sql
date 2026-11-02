-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice Smith', 'NY', 'Democratic', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Bob Jones', 'CA', 'Republican', '1965-present');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 1, '2020-11-03', 5000.5, 50.5, 2.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 2, '2020-11-03', 1200.0, 12.0, 0.0, 3.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 1, '2018-11-06', 3400.25, 34.0, 1.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (4, 2, '2016-11-08', 1200.0, 15.0, 1.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT votes FROM election ORDER BY votes, election.election_id NULLS LAST;

/*
Gold Result:
(1200.0,)
(1200.0,)
(3400.25,)
(5000.5,)
*/

-- Prediction Query
SELECT Votes FROM election ORDER BY Votes DESC, election.election_id NULLS LAST;

/*
Prediction Result:
(5000.5,)
(3400.25,)
(1200.0,)
(1200.0,)
*/